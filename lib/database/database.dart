//함수에 붙은 async -> 이 함수가 비동기적으로 동작함을 표시한다.
// 함수 내부 코드에 await -> 비동기로 동작하는 함수가 결과를 반환할 때 까지 기다린다.
// Future<T> -> 비동기로 동작하는 함수의 반환형이다.

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final notepadTable = "notepad_table";

class DatabaseProvider{
  static final DatabaseProvider provider = DatabaseProvider();

  Database _database;

  Future<Database> get database async{
    if(_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async{
    Directory docsDir = await getApplicationDocumentsDirectory();
    String path = join(docsDir.path, "notepad.db");

    var database = await openDatabase(path, version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion){
    if(newVersion > oldVersion){
      //TODO :: Migration
    }
  }

  void initDB(Database database, int version) async{
    await database.execute("CREATE TABLE $notepadTable("
        "id INTEGER PRIMARY KEY, "
        "title TEXT, "
        "state INTEGER,"
        "created_time INTEGER"
        ")");
  }
}