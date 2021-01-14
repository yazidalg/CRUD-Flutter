import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';
import 'package:flutter_sqfllite/model/class_model.dart';

class CRUD {
  static const tableName = 'contact';
  static const id = 'id';
  static const name = 'name';
  static const email = 'email';
  static const phone = 'phone';

  DbHelper dbHelper = new DbHelper();

  Future<int> insert(Model todo) async {
    Database db = await dbHelper.initDb();
    final sql = '''
          INSERT INTO ${CRUD.tableName} (${CRUD.name}, ${CRUD.phone})
          VALUES(?,?)
          ''';
    List<dynamic> params = [todo.name, todo.phone];
    final result = await db.rawInsert(sql, params);
    return result;
  }

  Future<int> update(Model todo) async {
    Database db = await dbHelper.initDb();
    final sql = '''
        UPDATE ${CRUD.tableName}
         SET ${CRUD.name} = ?, ${CRUD.phone} = ? 
         WHERE ${CRUD.id} = ?
         ''';
    List<dynamic> params = [todo.name, todo.phone, todo.id];
    final result = await db.rawUpdate(sql, params);
    return result;
  }

  Future<int> delete(Model todo) async {
    Database db = await dbHelper.initDb();
    final sql = '''
    DELETE FROM ${CRUD.tableName} 
    WHERE ${CRUD.id} = ?
    ''';

    List<dynamic> params = [todo.id];
    final result = await db.rawDelete(sql, params);
    return result;
  }

  Future<List<Model>> getContactList() async {
    Database db = await dbHelper.initDb();
    final sql = '''
    SELECT * FROM ${CRUD.tableName}
    ''';
    final data = await db.rawQuery(sql);
    List<Model> todos = List();

    for (final node in data) {
      final todo = Model.fromMap(node);
      todos.add(todo);
    }
    return todos;
  }
}
