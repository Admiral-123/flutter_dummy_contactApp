import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHandler {
  DBHandler._();

  final String contactTable = "CONTACT_TABLE";
  final String columnSno = "S_NO";
  final String columnName = "NAME";
  final String columnNum = "NUMBER";

  static final DBHandler getInstance = DBHandler._();

  Database? myDB;

  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    Directory appCacheDir = await getApplicationCacheDirectory();
    String dbPath = join(appCacheDir.path, "contactDB");

    return openDatabase(dbPath, onCreate: (db, version) {
      db.execute(
          "CREATE TABLE $contactTable ($columnSno INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT, $columnNum TEXT)");
    }, version: 1);
  }

  //read
  Future<List<Map<String, dynamic>>> getContact() async {
    var db = await getDB();

    List<Map<String, dynamic>> myData = await db.query(contactTable);

    return myData;
  }

  //create
  Future<void> addContact({required String name, required String num}) async {
    var db = await getDB();

    await db.insert(contactTable, {columnName: name, columnNum: num});
  }

  // update
  Future<void> updateContact(
      {required String name, required String num, required int sno}) async {
    var db = await getDB();

    await db.update(contactTable, {columnName: name, columnNum: num},
        where: "$columnSno = ?", whereArgs: [sno.toString()]);
  }

  // delete
  Future<void> deleteContact({required int sno}) async {
    var db = await getDB();
    await db.delete(contactTable, where: "$columnSno = ?", whereArgs: [sno]);
  }
}
