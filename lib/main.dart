import 'package:basic_app/screens/add_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent)
    );
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/addnote': (context) => const AddNote(noteTitle: ""),
      },
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      home: const Home(),
    );
  }
}
