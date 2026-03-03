import 'package:flutter/material.dart';
import '../models/post_model.dart';

// Screen for creating a new post
class CreatePostScreen extends StatefulWidget {
  final String username; // Stores the username of the person creating the post

  const CreatePostScreen({super.key, required this.username});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // Keeps track of the currently selected mood in the dropdown
  String selectedMood = "Happy";

  // Controller to read and manage the text input from the TextField
  final TextEditingController _contentController = TextEditingController();

  // Function to submit the post
  void submitPost() {
    // Ensure the post is not empty and under 150 characters
    if (_contentController.text.isNotEmpty &&
        _contentController.text.length <= 150) {
      // Close the screen and return a Post object to the previous screen
      Navigator.pop(
        context,
        Post(
          username: widget.username,       // Set username of the post
          mood: selectedMood,              // Set selected mood
          content: _contentController.text, // Set post content
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with the title
      appBar: AppBar(title: const Text("Create Post")),
      body: Padding(
        padding: const EdgeInsets.all(20), // Add space around content
        child: Column(
          children: [
            // Dropdown menu for selecting mood
            DropdownButton<String>(
              value: selectedMood, // Current selected mood
              items: ["Happy", "Sad", "Angry", "Stressed", "Motivated"]
                  .map((mood) => DropdownMenuItem(
                value: mood,  // Value returned when selected
                child: Text(mood), // Display text
              ))
                  .toList(),
              onChanged: (value) {
                // Update the selected mood and refresh UI
                setState(() {
                  selectedMood = value!;
                });
              },
            ),
            // Text input field for post content
            TextField(
              controller: _contentController, // Connect the controller
              maxLength: 150,                 // Limit characters
              decoration: const InputDecoration(
                labelText: "What's on your mind?", // Hint for user
                border: OutlineInputBorder(),       // Box border style
              ),
            ),
            const SizedBox(height: 20), // Add space between TextField and button
            // Button to submit the post
            ElevatedButton(
              onPressed: submitPost, // Calls submitPost when pressed
              child: const Text("Post"),
            )
          ],
        ),
      ),
    );
  }
}
