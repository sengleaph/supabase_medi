import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/auth_service.dart';
import '../../data/post_service.dart';
import '../../model/post_model.dart';
import '../home_page.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  // Auth and Post services
  final _auth = AuthService();
  final _post = PostService();

  // Controllers and Image file
  final TextEditingController postTextController = TextEditingController();
  File? _selectedImage;

  // Pick an image from the gallery
  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();

      // pick image
      // final  pickedFile =
      // await ImagePicker().pickImage(source: ImageSource.gallery);
final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);


      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  // Clear input fields and reset state
  void clearFields() {
    postTextController.clear();
    setState(() {
      _selectedImage = null;
    });
  }

  // Save post function
  // Future<void> savePost() async {
  //   final userEmail = _auth.getCurrentUserEmail();
  //   if (postTextController.text.isNotEmpty && _selectedImage != null && userEmail != null) {
  //     final newPost = Post(
  //       content: postTextController.text,
  //       image: _selectedImage!, // Using the actual image path
  //       email: userEmail,  // Use current user's email instead of name
  //     );
  //
  //     try {
  //       await _post.createNotes(newPost);
  //       clearFields();
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Post saved successfully!')),
  //       );
  //       Navigator.pop(context); // Return to the previous screen
  //     } catch (e) {
  //       print('Failed to save post: $e');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to save post: $e')),
  //       );
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please provide content and an image')),
  //     );
  //   }
  // }
  Future<void> savePost() async {
    final userEmail = _auth.getCurrentUserEmail();
    if (postTextController.text.isNotEmpty && _selectedImage != null && userEmail != null) {
      try {
        await _post.insertPost(postTextController.text, _selectedImage!,);
        clearFields();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post saved successfully!')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save post: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide content and an image')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Return to the previous screen
            clearFields();
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: pickImage,
            icon: const Icon(
              Icons.insert_photo_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Removed the name text field since we use the current user's email
            const SizedBox(height: 16),
            TextField(
              controller: postTextController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            _selectedImage == null
                ? Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
            )
                : Column(
              children: [
                Image.file(
                  _selectedImage!,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
                TextButton(
                  onPressed: () => setState(() {
                    _selectedImage = null;
                  }),
                  child: const Text('Remove Image'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: savePost,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,

            decoration: BoxDecoration(color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
