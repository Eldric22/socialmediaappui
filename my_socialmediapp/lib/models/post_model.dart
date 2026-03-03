class Post {
  final String username;
  final String mood;
  final String content;
  int supports;

  Post({
    required this.username,
    required this.mood,
    required this.content,
    this.supports = 0,
  });
}