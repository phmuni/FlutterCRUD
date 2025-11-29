import 'dart:convert';
import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/tarefa.dart';

class FormPage extends StatefulWidget {
  final Tarefa? tarefa;

  const FormPage({super.key, this.tarefa});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _tipoEventoController = TextEditingController();

  int _prioridadeSelecionada = 2;
  bool _isEdicao = false;

  final List<String> _tiposEventoSugestoes = [
    'Reunião',
    'Evento',
    'Workshop',
    'Palestra',
    'Conferência',
    'Treinamento',
    'Outro',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.tarefa != null) {
      _isEdicao = true;
      _tituloController.text = widget.tarefa!.titulo;
      _descricaoController.text = widget.tarefa!.descricao ?? '';
      _prioridadeSelecionada = widget.tarefa!.prioridade;
      _tipoEventoController.text = widget.tarefa!.tipoEvento;
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _tipoEventoController.dispose();
    super.dispose();
  }

  Future<void> _salvarTarefa() async {
    if (_formKey.currentState!.validate()) {
      final dbHelper = DatabaseHelper.instance;

      if (_isEdicao) {
        // Edição - já tem ID
        final tarefa = Tarefa(
          id: widget.tarefa!.id,
          titulo: _tituloController.text.trim(),
          descricao: _descricaoController.text.trim().isEmpty
              ? null
              : _descricaoController.text.trim(),
          prioridade: _prioridadeSelecionada,
          criadoEm: widget.tarefa!.criadoEm,
          tipoEvento: _tipoEventoController.text.trim(),
        );

        await dbHelper.updateTarefa(tarefa);

        // Log do JSON para print obrigatório
        print('=== TAREFA EDITADA (JSON) ===');
        print(jsonEncode(tarefa.toJson()));
        print('=============================');
      } else {
        // Criação - inserir primeiro para obter o ID
        final tarefaTemp = Tarefa(
          titulo: _tituloController.text.trim(),
          descricao: _descricaoController.text.trim().isEmpty
              ? null
              : _descricaoController.text.trim(),
          prioridade: _prioridadeSelecionada,
          criadoEm: DateTime.now().toIso8601String(),
          tipoEvento: _tipoEventoController.text.trim(),
        );

        // Inserir e obter o ID gerado
        final idGerado = await dbHelper.insertTarefa(tarefaTemp);

        // Criar objeto com ID real para o log
        final tarefaComId = Tarefa(
          id: idGerado,
          titulo: tarefaTemp.titulo,
          descricao: tarefaTemp.descricao,
          prioridade: tarefaTemp.prioridade,
          criadoEm: tarefaTemp.criadoEm,
          tipoEvento: tarefaTemp.tipoEvento,
        );

        // Log do JSON para print obrigatório - AGORA COM ID!
        print('=== TAREFA CRIADA (JSON) ===');
        print(jsonEncode(tarefaComId.toJson()));
        print('============================');
      }

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEdicao
                  ? 'Tarefa atualizada com sucesso!'
                  : 'Tarefa criada com sucesso!',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdicao ? 'Editar Tarefa' : 'Nova Tarefa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título *',
                  hintText: 'Digite o título da tarefa',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'O título é obrigatório';
                  }
                  if (value.trim().length < 3) {
                    return 'O título deve ter no mínimo 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Digite a descrição (opcional)',
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                initialValue: _prioridadeSelecionada,
                decoration: const InputDecoration(
                  labelText: 'Prioridade *',
                  prefixIcon: Icon(Icons.priority_high),
                ),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('🟢 Baixa')),
                  DropdownMenuItem(value: 2, child: Text('🟡 Média')),
                  DropdownMenuItem(value: 3, child: Text('🔴 Alta')),
                ],
                onChanged: (value) {
                  setState(() {
                    _prioridadeSelecionada = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione uma prioridade';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tipoEventoController,
                decoration: InputDecoration(
                  labelText: 'Tipo de Evento *',
                  hintText: 'Digite o tipo do evento',
                  prefixIcon: const Icon(Icons.event),
                  suffixIcon: PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      _tipoEventoController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return _tiposEventoSugestoes.map((String tipo) {
                        return PopupMenuItem<String>(
                          value: tipo,
                          child: Text(tipo),
                        );
                      }).toList();
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'O tipo de evento é obrigatório';
                  }
                  if (value.trim().length < 3) {
                    return 'O tipo deve ter no mínimo 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _salvarTarefa,
                icon: Icon(_isEdicao ? Icons.save : Icons.add),
                label: Text(_isEdicao ? 'Salvar Alterações' : 'Criar Tarefa'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
