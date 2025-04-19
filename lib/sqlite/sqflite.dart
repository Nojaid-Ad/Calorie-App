import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MySql {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    }
    return _db;
  }

  initialDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'nojaid.db');
    Database dba = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dba;
  }

  _onCreate(Database db, int version) {
    Batch batch = db.batch();
    batch.execute('''CREATE TABLE option(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      imageUrl TEXT,
      unit TEXT NOT NULL,
      weight INTEGER NOT NULL,
      calorie INTEGER NOT NULL,
      protein INTEGER NOT NULL,
      carps INTEGER NOT NULL,
      fat INTEGER NOT NULL
      )
      ''');
    batch.execute('''CREATE TABLE meel(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL,
      title TEXT NOT NULL,
      imageUrl TEXT,
      unit TEXT NOT NULL,
      weight INTEGER NOT NULL,
      calorie INTEGER NOT NULL,
      protein INTEGER NOT NULL,
      carps INTEGER NOT NULL,
      fat INTEGER NOT NULL
      )
      ''');
    batch.commit();
  }

  readData(String sql) async {
    Database? sqlDb = await db;
    List<Map> response = await sqlDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? sqlDb = await db;
    int response = await sqlDb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? sqlDb = await db;
    int response = await sqlDb!.rawUpdate(sql);
    return response;
  }

  deleteApp() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'nojaid.db');
    GetStorage().erase();
    deleteDatabase(path);
    SystemNavigator.pop();
  }

  deleteData(String sql) async {
    Database? sqlDb = await db;
    int response = await sqlDb!.rawDelete(sql);
    return response;
  }
}
