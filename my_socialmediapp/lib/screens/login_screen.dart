import 'package:flutter/material.dart';
import 'home_screen.dart';

// Login screen where the user enters a username
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller for the username text field
  final TextEditingController _usernameController = TextEditingController();

  // Function to handle login action
  void login() {
    // Only proceed if the username field is not empty
    if (_usernameController.text.isNotEmpty) {
      // Navigate to HomeScreen and pass the entered username
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            username: _usernameController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background for the whole screen
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.purple.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25), // Space around the column
            child: Column(
              mainAxisSize: MainAxisSize.min, // Wraps content vertically
              children: [
                // App title
                const Text(
                  "WeConnect",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Username input field
                TextField(
                  controller: _usernameController, // Connect controller
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9), // Slightly transparent
                    labelText: "Enter your username",
                    labelStyle: const TextStyle(color: Colors.black87),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15), // Rounded edges
                      borderSide: BorderSide.none, // Remove default border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Enter button
                SizedBox(
                  width: double.infinity, // Fill horizontal space
                  height: 50,             // Fixed height
                  child: ElevatedButton(
                    onPressed: login, // Calls login function when pressed
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Rounded edges
                      ),
                      elevation: 5,          // Button shadow
                      shadowColor: Colors.black26,
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: const Text("Enter"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
