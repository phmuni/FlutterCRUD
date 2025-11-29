class Tarefa {
  final int? id;
  final String titulo;
  final String? descricao;
  final int prioridade; // 1=Baixa, 2=Média, 3=Alta
  final String criadoEm;
  final String tipoEvento; // Campo extra

  Tarefa({
    this.id,
    required this.titulo,
    this.descricao,
    required this.prioridade,
    required this.criadoEm,
    required this.tipoEvento,
  });

  // Converter para Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'prioridade': prioridade,
      'criadoEm': criadoEm,
      'tipoEvento': tipoEvento,
    };
  }

  // Criar Tarefa a partir de Map
  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      prioridade: map['prioridade'],
      criadoEm: map['criadoEm'],
      tipoEvento: map['tipoEvento'],
    );
  }

  // Converter para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'prioridade': prioridade,
      'prioridadeNome': _getPrioridadeNome(),
      'criadoEm': criadoEm,
      'tipoEvento': tipoEvento,
    };
  }

  String _getPrioridadeNome() {
    switch (prioridade) {
      case 1:
        return 'Baixa';
      case 2:
        return 'Média';
      case 3:
        return 'Alta';
      default:
        return 'Indefinida';
    }
  }

  String get prioridadeTexto => _getPrioridadeNome();
}
