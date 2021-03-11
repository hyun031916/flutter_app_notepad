import 'dart:async';
import 'package:flutter_app_notepad/database.dart';
import 'package:flutter_app_notepad/models/notepad_model.dart';

class NotePadDao{
  final dbProvider = DatabaseProvider.provider;

  Future<int> createNotePad(NotePadModel notepad) async{
    final db = await dbProvider.database;
    final result = db.insert(notepadTable, notepad.toDatabaseJson());
    return result;
  }

  Future<List<NotePadModel>> getNotePadList() async{
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result = await db.query(notepadTable);
    List<NoePadModel> notepadList = result.isNotEmpty ? result.map((item)=> NotePadModel.fromDatabaseJson(item)).toList():[];

    return notepadList;
  }
}