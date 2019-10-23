import '../model/Dog.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as developer;

final dogTable = 'dogs';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
   Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory,'dog_database.db');

    var database = await openDatabase(path,
      version: 1, onCreate: initDB
    );
    return database;
  }

  initDB(Database database, int version) async {
    await database.execute(
        "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)"
    );
  }
}