import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DB {
  //construtor com acesso privado

  DB._();
  // criar uma instancia de db

  static final DB instance = DB._();

  //instancia do SQLITE
  static Database? _database;

  get database async {
    if (_database != null) {
      return _database;
    } else {
      return await _initDatabase();
    }
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'cripto.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    await db.execute(_account);
    await db.execute(_wallet);
    await db.execute(_history);
    await db.insert('conta', {'balance': 0});
  }

  String get _account => '''
    CREATE TABLE conta(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      balance REAL
    );
  ''';

  String get _wallet => '''
    CREATE TABLE wallet(
      sigla TEXT PRIMARY KEY,
      coin TEXT,
      quantity TEXT
    );
  ''';

  String get _history => '''
    CREATE TABLE history(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      data_operation INT,
      type_operation TEXT,
      coin TEXT,
      sigla TEXT,
      value TEXT,
      quantity TEXT
    );
''';
}
