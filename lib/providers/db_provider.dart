import 'package:contact_app/db/db_handler.dart';
import 'package:flutter/material.dart';

class DBProvider extends ChangeNotifier {
  DBHandler dbRef = DBHandler.getInstance;

  List<Map<String, dynamic>> _contacts = [];
  List<Map<String, dynamic>> get contacts => _contacts;

  Future<void> getContactProv() async {
    _contacts = await dbRef.getContact();

    notifyListeners();
  }

  Future<void> addContactProv(
      {required String mname, required String mnum}) async {
    await dbRef.addContact(name: mname, num: mnum);
    notifyListeners();
  }

  Future<void> updateContactProv(
      {required String mname, required String mnum, required int id}) async {
    await dbRef.updateContact(name: mname, num: mnum, sno: id);
    notifyListeners();
  }

  Future<void> deleteContactProv({required int id}) async {
    await dbRef.deleteContact(sno: id);
    notifyListeners();
  }
}
