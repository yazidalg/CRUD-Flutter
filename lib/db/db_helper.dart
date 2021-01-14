import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper{
  Future<Database> initDb() async {
    //getApplicationDocumentsDirectory() berfungsi untuk mengambil direktori folder aplikasi untuk menempatkan data yang dibuat pengguna tidak dapat dibuat ulang oleh aplikasi Anda.
    Directory directory = await getApplicationDocumentsDirectory();
    //String path, untuk membuat nama database kita dengan mengambil lokasi directory nya dan menambahkannya dengan nama database.
    String path = directory.path + 'contact.db';
    var todo = openDatabase(path, version: 1, onCreate: _createDb);
    return todo;
  }

  _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE contact
    (
    id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    phone TEXT
    )
    ''');
  }
}