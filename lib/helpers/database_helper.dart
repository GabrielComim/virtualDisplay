import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:virtual_display/models/automation.dart';
import 'package:virtual_display/models/credentials_broker.dart';

// Não use o nome Database apenas pois dá conflito com a própria blibioteca.
class DatabaseHelper {
  // Estrutura para que independente de onde for chamado usa sempre a mesma instância.
  static final DatabaseHelper instance = DatabaseHelper._internal();
  factory DatabaseHelper() => instance;
  DatabaseHelper._internal();

  // Função get
  static Database? _database;
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  // Inicializa o banco de dados
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'virtualDisplay.db');

    return await openDatabase(
      path,
      version: 1, // Sempre que alterar algo é necessário subir uma versão
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Acrescentar cada alteração conforme evoluir as versões
  }

  Future<void> _onCreate(Database db, int version) async {
    // CREDENCIAIS PARA O BROKER
    await db.execute('''
      CREATE TABLE credentials_broker(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        broker TEXT NOT NULL,
        username TEXT,
        password TEXT,
        tls INTEGER NOT NULL
      )  
    ''');
    // AUTOMAÇÕES
    await db.execute('''
      CREATE_TABLE automations(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        enable INTEGER NOT NULL DEFAULT 1,
        action TEXT NOT NULL,
        triggerConfig TEXT NOT NULL
      )
    ''');
  }

  // ================ MÉTODO PARA CREDENCIAIS BROKER ================
  // CRUD
  // Create
  Future<int> insertCredentials(CredentialsBroker credentials) async {
    final db = await database;
    return await db.insert('credentials_broker', credentials.toMap());
  }

  // Get lista de credenciais
  Future<List<CredentialsBroker>> getCredential() async {
    final db = await database;
    final result = await db.query('credentials_broker');
    return result.map((map) => CredentialsBroker.fromMap(map)).toList();
  }

  // Update
  Future<void> updateCredential(CredentialsBroker credentials) async {
    final db = await database;
    await db.update(
      'credentials_broker',
      credentials.toMap(),
      where: 'id = ?',
      whereArgs: [credentials.id],
    );
  }

  // Delete
  Future<void> deleteCredential(int id) async {
    final db = await database;
    await db.delete('credentials_broker', where: 'id = ?', whereArgs: [id]);
  }

  // ================ MÉTODO PARA AUTOMAÇÕES ================
  // CREATE
  Future<int> insertAutomation(Automation automation) async {
    final db = await database;
    return await db.insert('automation', automation.toMap());
  }
  
  // GET 
  Future<List<Automation>> getAutomation() async {
    final db = await database;
    final result = await db.query('automation');
    return result.map((map) => Automation.fromMap(map)).toList();
  }
  
  // UPDATE
  Future<void> updateAutomation(Automation automation) async {
    final db = await database;
    await db.update(
      'automation',
      automation.toMap(),
      where: 'id = ?',
      whereArgs: [automation.id],
    );
  }
  
  // DELETE
  Future<void> deleteAutomation(int id) async {
    final db = await database;
    await db.delete('automation', where: 'id = ?', whereArgs: [id]);
  }
}
