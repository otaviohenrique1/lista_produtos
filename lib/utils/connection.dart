import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteDB {
  static final SqliteDB _singleton = new SqliteDB._internal();

  factory SqliteDB() {
    return _singleton;
  }

  SqliteDB._internal();

  static Database _database;

  static Future<Database> connect() async {
    if (_database != null) {
      return _database;
    }

    var databasePath = await getDatabasesPath();

    final String path = join(databasePath, 'store_db.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE produtos (id INTEGER PRIMARY KEY, nome TEXT, quantidade TEXT)');
      },
    );

    return _database;
  }
}
