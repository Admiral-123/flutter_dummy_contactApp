import 'package:contact_app/pages/add_contacts.dart';
import 'package:contact_app/pages/edit_contacts.dart';
import 'package:contact_app/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact'),
          backgroundColor: const Color.fromARGB(255, 209, 61, 61),
        ),
        body: Consumer<DBProvider>(builder: (ctx, provider, _) {
          var allData = provider.contacts;
          provider.getContactProv();

          return allData.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Color.fromARGB(255, 226, 211, 211)),
                        child: ListTile(
                          leading: Text(index.toString()),
                          title: Text(allData[index]["NAME"] ?? "no contacts"),
                          subtitle: Text(allData[index]["NUMBER"] ?? "-"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditContacts(
                                                  sno: allData[index]["S_NO"],
                                                  name: allData[index]["NAME"],
                                                  num: allData[index]["NUMBER"],
                                                )));
                                  },
                                  child: const Icon(Icons.edit)),
                              InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: (context),
                                        builder: (context) {
                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 1500), () {
                                            Navigator.pop(context);
                                          });
                                          return const AlertDialog(
                                            title: Center(
                                              child: Text(
                                                'Delete Warning !',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      'Tap twice to delete',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  onDoubleTap: () {
                                    context
                                        .read<DBProvider>()
                                        .deleteContactProv(
                                            id: allData[index]["S_NO"]);
                                  },
                                  child: const Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: allData.length,
                )
              : const Center(
                  child: Text('no contacts'),
                );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddContacts()));
          },
          child: const Icon(Icons.add),
        ));
  }
}
