import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/tarefa.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'tarefas_202310166.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tarefas(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT NOT NULL,
            descricao TEXT,
            prioridade INTEGER NOT NULL,
            criadoEm TEXT NOT NULL,
            tipoEvento TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // CRUD - CREATE
  Future<int> insertTarefa(Tarefa tarefa) async {
    final db = await database;
    return await db.insert('tarefas', tarefa.toMap());
  }

  // CRUD - READ
  Future<List<Tarefa>> getAllTarefas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tarefas',
      orderBy: 'prioridade DESC, criadoEm DESC',
    );

    return List.generate(maps.length, (i) {
      return Tarefa.fromMap(maps[i]);
    });
  }

  // CRUD - UPDATE
  Future<int> updateTarefa(Tarefa tarefa) async {
    final db = await database;
    return await db.update(
      'tarefas',
      tarefa.toMap(),
      where: 'id = ?',
      whereArgs: [tarefa.id],
    );
  }

  // CRUD - DELETE
  Future<int> deleteTarefa(int id) async {
    final db = await database;
    return await db.delete(
      'tarefas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Fechar o banco
  Future close() async {
    final db = await database;
    db.close();
  }
}
