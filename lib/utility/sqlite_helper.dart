import 'dart:ffi';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:yhinsqlite/models/todo_model.dart';

class SQLiteHelper {
  // Field
  String nameDatabase = 'todo.db';
  int versionDatabase = 1;
  String nameTable = 'todoTABLE';
  String columnID = 'id';
  String columnToDo = 'ToDo';

  // Method

  SQLiteHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (Database database, int version) {
      return database.execute(
          'CREATE TABLE $nameTable ($columnID INTEGER PRIMARY KEY, $columnToDo TEXT)');
    }, version: versionDatabase);
  }

  Future<void> insertValueToSQLite(ToDoModel model) async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), nameDatabase),
    );

    try {
      database.insert(
        nameTable,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Insert OK');
    } catch (e) {
      print('e ===>>> ${e.toString()}');
    }
  }

  Future<List<ToDoModel>> readAllData() async {
    Database database =
        await openDatabase(join(await getDatabasesPath(), nameDatabase));
    List<ToDoModel> todoModels = List();
    List<Map<String, dynamic>> list = await database.query(nameTable);

    for (var map in list) {
      ToDoModel model = ToDoModel.fromMap(map);
      todoModels.add(model);
    }

    return todoModels;
  }

  Future<Void> deleteSQLiteWhereId(int id) async {
    Database database =
        await openDatabase(join(await getDatabasesPath(), nameDatabase));

    try {
      await database.delete(nameTable, where: '$columnID = $id');
    } catch (e) {
      print('e of Delete ===>>> ${e.toString()}');
    }
  }

  Future<void> updateSQLiteWhereId(ToDoModel model) async {
    print('id ===>>> ${model.id}, ToDo new ===>>> ${model.todo}');
    Database database =
        await openDatabase(join(await getDatabasesPath(), nameDatabase));
    try {
      await database.update(nameTable, model.toMap(),
          where: '$columnID = ${model.id}');
    } catch (e) {
      print('e edit ===>>> ${e.toString()}');
    }
  }
}
