import 'dart:async';
import 'package:contact_app/pages/home.dart';
import 'package:contact_app/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => DBProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Contacts",
      theme: ThemeData(colorSchemeSeed: const Color.fromARGB(255, 254, 76, 76)),
      home: const SplashScr(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScr extends StatefulWidget {
  const SplashScr({super.key});

  @override
  State<SplashScr> createState() => SplashScrState();
}

class SplashScrState extends State<SplashScr> {
  @override
  void initState() {
    super.initState();

    intro();
  }

  void intro() async {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: const Center(
          child: Icon(
            Icons.call,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}
