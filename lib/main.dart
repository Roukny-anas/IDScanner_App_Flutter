import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/idscanner_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth',
      theme: ThemeData(
        primarySwatch: Colors.green, // Set the primary color to green
      ),
      initialRoute: '/login', // Set the initial route to the LoginPage
      routes: {
        '/login': (context) => LoginPage(), // Route for the LoginPage
        '/signup': (context) => SignupPage(), // Route for the SignupPage
        '/idscanner': (context) => IDScannerPage(), 
      },
    );
  }
}