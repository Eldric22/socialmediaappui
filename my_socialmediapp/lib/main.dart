import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

// Entry point of the Flutter app
void main() {
  runApp(const WeConnect()); // Launches the app and attaches the root widget
}

// Root widget of the app
class WeConnect extends StatelessWidget {
  const WeConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      title: 'WeConnect',               // App title
      theme: ThemeData(
        primarySwatch: Colors.blue,     // Primary color theme for app
      ),
      home: const LoginScreen(),        // First screen the user sees
    );
  }
}

