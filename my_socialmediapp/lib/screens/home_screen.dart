import 'package:flutter/material.dart';
import '../models/post_model.dart';
import 'create_post_screen.dart';

// Main screen of the app with tabs for Home, Profile, and Share Photo
class HomeScreen extends StatefulWidget {
  final String username; // Stores the username of the logged-in user

  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // Controller for managing the tabs
  late TabController _tabController;

  // List of all posts created
  List<Post> posts = [];

  // Currently selected mood filter for the Home tab
  String selectedMood = "All";

  @override
  void initState() {
    super.initState();
    // Initialize TabController for 3 tabs (Home, Profile, Share Photo)
    _tabController = TabController(length: 3, vsync: this);
  }

  // Function to add a new post to the list and update the UI
  void addPost(Post post) {
    setState(() {
      posts.add(post);
    });
  }

  // Returns a color based on the mood of the post
  Color getMoodColor(String mood) {
    switch (mood) {
      case "Happy":
        return Colors.orange.shade100;
      case "Sad":
        return Colors.blue.shade100;
      case "Angry":
        return Colors.red.shade100;
      case "Stressed":
        return Colors.purple.shade100;
      case "Motivated":
        return Colors.green.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter posts by selected mood if a specific mood is selected
    List<Post> filteredPosts = selectedMood == "All"
        ? posts
        : posts.where((post) => post.mood == selectedMood).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("WeConnect"),
        // Tabs for navigation
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: "Home"),
            Tab(icon: Icon(Icons.person), text: "Profile"),
            Tab(icon: Icon(Icons.photo_camera), text: "Share Photo"),
          ],
        ),
        // Mood filter dropdown shown only on Home tab
        actions: _tabController.index == 0
            ? [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: DropdownButton<String>(
              value: selectedMood, // Current mood filter
              underline: const SizedBox(), // Remove underline
              items: [
                "All",
                "Happy",
                "Sad",
                "Angry",
                "Stressed",
                "Motivated"
              ]
                  .map((mood) => DropdownMenuItem(
                value: mood,
                child: Text(mood),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedMood = value!;
                });
              },
            ),
          )
        ]
            : null,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // HOME TAB
          Column(
            children: [
              // 🌤 Daily Prompt Banner (UI only)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.lightBlueAccent],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "🌤 Daily Prompt",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "What made you smile today?",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),

              // Mood Streak Badge (UI only)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: const [
                    Icon(Icons.local_fire_department, color: Colors.orange),
                    SizedBox(width: 5),
                    Text("3 Day Mood Sharing Streak 🔥"),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Posts List
              Expanded(
                child: filteredPosts.isEmpty
                    ? const Center(
                  child: Text(
                    "No posts yet.\nTap + to share your mood!",
                    textAlign: TextAlign.center,
                  ),
                )
                    : ListView.builder(
                  itemCount: filteredPosts.length,
                  itemBuilder: (context, index) {
                    final post = filteredPosts[index];

                    return Card(
                      color: getMoodColor(post.mood), // Color by mood
                      margin: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${post.username} • ${post.mood}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(post.content), // Post content
                            const SizedBox(height: 15),
                            // Likes and emoji icons row
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                // Like button and counter
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.favorite,
                                          color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          post.supports++;
                                        });
                                      },
                                    ),
                                    Text("${post.supports}"),
                                  ],
                                ),
                                // Decorative emoji icons
                                Row(
                                  children: const [
                                    Icon(Icons.emoji_emotions,
                                        color: Colors.orange),
                                    SizedBox(width: 5),
                                    Icon(Icons.mood, color: Colors.blue),
                                    SizedBox(width: 5),
                                    Icon(Icons.sentiment_very_satisfied,
                                        color: Colors.green),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // PROFILE TAB
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  AssetImage('assets/profile_placeholder.png'), // placeholder
                ),
                const SizedBox(height: 10),
                Text(widget.username,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                const Text("Hello! I'm using WeConnect."),
              ],
            ),
          ),

          // SHARE PHOTO TAB
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.photo_camera, size: 60, color: Colors.grey),
                SizedBox(height: 10),
                Text("Share a photo here"),
              ],
            ),
          ),
        ],
      ),
      // Floating action button to add a new post (only on Home tab)
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // Navigate to CreatePostScreen and wait for the new post
          final newPost = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreatePostScreen(username: widget.username),
            ),
          );

          // Add the new post to the posts list
          if (newPost != null && newPost is Post) {
            addPost(newPost);
          }
        },
      )
          : null,
    );
  }
}

