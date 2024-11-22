class Post {
  String? id;
  String content;
  String? email;
  String image;

  Post({
    this.id,
    required this.content,
    this.email,
    required this.image,
  });

  // map -> post
  factory Post.fromMap(Map<String, dynamic> postMap) {
    return Post(
      id: postMap['id']?.toString(), // Convert to String if it's not already
      content: postMap['content'] as String,
      email: postMap['email']?.toString(), // Convert to String if it's not already
      image: postMap['image']?.toString() ?? '', // Convert to String and ensure it's not null
    );
  }


  // post -> map
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'content': content,
      'image': image,
    };
  }
}