import 'package:contact_app/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditContacts extends StatelessWidget {
  final int sno;
  final String name;
  final String num;
  const EditContacts(
      {super.key, required this.sno, required this.name, required this.num});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController numController = TextEditingController(text: num);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Edit Contacts'),
          backgroundColor: const Color.fromARGB(255, 254, 76, 76)),
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
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: false),
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
                  context.read<DBProvider>().updateContactProv(
                      mnum: numController.text,
                      mname: nameController.text,
                      id: sno);

                  Navigator.pop(context);
                }
              },
              child: const Text('Save'))
        ],
      ),
    );
  }
}
