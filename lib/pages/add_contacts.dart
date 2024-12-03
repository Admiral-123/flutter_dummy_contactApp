import 'package:contact_app/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddContacts extends StatelessWidget {
  AddContacts({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController numController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contacts'),
        backgroundColor: const Color.fromARGB(255, 254, 76, 76),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  labelText: "name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.black))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: numController,
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(
                  labelText: "number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.black))),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (nameController.text != "" && numController.text != "") {
                  context.read<DBProvider>().addContactProv(
                      mname: nameController.text.toString(),
                      mnum: numController.text.toString());

                  Navigator.pop(context);
                }
              },
              child: const Text('Save'))
        ],
      ),
    );
  }
}
