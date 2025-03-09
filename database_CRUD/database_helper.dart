import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'user.dart';

class DatabaseHelper {
  static Database? _database;
  static const _databaseName = "person_database.db";
  static const _databaseVersion = 1;
  static const table = 'person';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL,
        city TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(Person person) async {
    Database db = await instance.database;
    return await db.insert(table, person.toMap());
  }

  Future<int> update(Person person) async {
    Database db = await instance.database;
    return await db.update(
      table,
      person.toMap(),
      where: 'id = ?',
      whereArgs: [person.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Person>> getAllPersons() async {
    Database db = await instance.database;
    var result = await db.query(table);
    return result.map((e) => Person.fromMap(e)).toList();
  }
}
