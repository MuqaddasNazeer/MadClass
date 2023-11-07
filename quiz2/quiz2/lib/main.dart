import 'package:flutter/material.dart';
import 'package:quiz2/screens/account_screen.dart';
import 'package:quiz2/screens/forgot_password_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/account', // Set the initial route
      routes: {
        '/account': (context) => AccountScreen(),
        '/forgot_password': (context) => ForgotPasswordScreen(),
      },
    );
  }
}
