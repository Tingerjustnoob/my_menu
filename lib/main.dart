import 'package:flutter/material.dart';
import 'Untitled-1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '餐品介紹',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const untitled1(),
      routes: {
        '/home': (context) => const untitled1(),
      },
    );
  }
}
