# Gerenciador de Tarefas - Prova Prática Flutter

Aplicativo de gerenciamento de tarefas desenvolvido em Flutter com banco de dados SQLite local.

## 👨‍🎓 Dados do Aluno

- **Nome:** Pedro Henrique Municelli
- **RA:** 202310166
- **Campo Personalizado:** tipoEvento (tipo de evento associado à tarefa)
- **Tema:** temaIce
- **Cor Primária:** Cyan (`Colors.cyan`)
- **Cor Secundária:** White70 (`Colors.white70`)
- **Banco de Dados:** `tarefas_202310166.db`

## 🎯 Funcionalidades

### CRUD Completo

- ✅ **Create:** Criar novas tarefas com validação de campos
- ✅ **Read:** Listar todas as tarefas ordenadas por prioridade
- ✅ **Update:** Editar tarefas existentes
- ✅ **Delete:** Excluir tarefas com confirmação

### Validações Implementadas

- Título obrigatório (mínimo 3 caracteres)
- Prioridade obrigatória (Baixa/Média/Alta)
- Tipo de Evento obrigatório (mínimo 3 caracteres)

### Campos da Tarefa

- **ID:** Chave primária auto-incremento
- **Título:** Texto obrigatório
- **Descrição:** Texto opcional
- **Prioridade:** Integer (1=Baixa, 2=Média, 3=Alta)
- **Criado Em:** Data/hora no formato ISO-8601
- **Tipo Evento:** Campo extra personalizado (obrigatório)

## 🚀 Como Rodar o Projeto

### Pré-requisitos

- Flutter SDK (stable channel)
- Emulador Android ou dispositivo físico
- Editor de código (VS Code, Android Studio)

### Passos

1. **Clone o repositório**

```bash
git clone https://github.com/phmuni/FlutterCRUD
cd FlutterCRUD
```

2. **Instale as dependências**

```bash
flutter pub get
```

3. **Execute o aplicativo**

```bash
flutter run
```

## 📦 Dependências

```yaml
dependencies:
  sqflite: ^2.3.0 # Banco de dados SQLite
  path_provider: ^2.1.1 # Acesso ao sistema de arquivos
  path: ^1.8.3 # Manipulação de caminhos
```

## 🎨 Tema Visual

O aplicativo utiliza o **temaIce** com as seguintes características:

- Cor primária: Cyan (AppBar, FAB, botões)
- Cor secundária: White70 (elementos de destaque)
- Cards com elevação e bordas arredondadas
- Ícones coloridos por prioridade (🔴 Alta, 🟡 Média, 🟢 Baixa)

## Dificuldades Encontradas

1. **Configuração inicial do SQLite:** Ajustar o caminho correto do banco com o RA no nome
2. **Atualização da ListView:** Garantir que a lista recarregue após operações de CRUD
3. **Validações:** Implementar validações completas no formulário mantendo boa UX
4. **Tema personalizado:** Aplicar as cores cyan e white70 de forma consistente e natural

---

**Desenvolvido com ❄️ usando o tema temaIce**
