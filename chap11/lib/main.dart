import 'package:flutter/material.dart';
import 'package:chap11/pages/home.dart'; // Import your home.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
    );
  }
}
