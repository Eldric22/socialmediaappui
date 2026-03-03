import 'package:flutter/material.dart';
import '../models/post_model.dart';

// This screen allows the user to create a new post
class CreatePostScreen extends StatefulWidget {
  final String username; // The username of the person creating the post

  const CreatePostScreen({super.key, required this.username});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // Stores the currently selected mood in the dropdown
  String selectedMood = "Happy";

  // Controller for the text input field to read and manage post content
  final TextEditingController _contentController = TextEditingController();

  // Function to handle submitting a post
  void submitPost() {
    // Only submit if content is not empty and under 150 characters
    if (_contentController.text.isNotEmpty &&
        _contentController.text.length <= 150) {
      // Return the new Post object back to the previous screen
      Navigator.pop(
        context,
        Post(
          username: widget.username, // Set the username from the widget
          mood: selectedMood,        // Use the selected mood
          content: _contentController.text, // Use the text input
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with title
      appBar: AppBar(title: const Text("Create Post")),
      body: Padding(
        padding: const EdgeInsets.all(20), // Add padding around the content
        child: Column(
          children: [
            // Dropdown for selecting mood
            DropdownButton<String>(
              value: selectedMood, // Current selected mood
              items: ["Happy", "Sad", "Angry", "Stressed", "Motivated"]
                  .map((mood) => DropdownMenuItem(
                value: mood, // Value to return when selected
                child: Text(mood), // Text shown in the dropdown
              ))
                  .toList(),
              onChanged: (value) {
                // Update the selectedMood when the user chooses a different mood
                setState(() {
                  selectedMood = value!;
                });
              },
            ),
            // TextField for typing post content
            TextField(
              controller: _contentController, // Connect the controller
              maxLength: 150, // Limit characters to 150
              decoration: const InputDecoration(
                labelText: "What's on your mind?", // Hint label
                border: OutlineInputBorder(),       // Box border
              ),
            ),
            const SizedBox(height: 20), // Space between TextField and button
            // Button to submit the post
            ElevatedButton(
              onPressed: submitPost, // Call submitPost when pressed
              child: const Text("Post"),
            )
          ],
        ),
      ),
    );
  }
}

