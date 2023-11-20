import 'package:flutter/material.dart';
import 'package:todo_app/screens/todohome.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      home: ToDoApp(),
    );
  }
}
