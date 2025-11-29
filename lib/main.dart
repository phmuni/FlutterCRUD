import 'package:flutter/material.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarefas - RA 202310166',
      theme: temaIce,
      debugShowCheckedModeBanner: false,
      home: const HomePage(), // A implementar
    );
  }
}
