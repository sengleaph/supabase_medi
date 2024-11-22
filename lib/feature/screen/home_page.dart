import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_app_supabase/feature/screen/post/post_page.dart';

import '../data/auth_service.dart';
import '../data/post_service.dart';
import '../model/post_model.dart';
import '../utils/component/my_drawer.dart';
import 'new_feed/newfeed_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get auth service
  final _auth = AuthService();
  //
  // // get post service
  // final _post = PostService();
  //
  // // text controller
  // final postTextController = TextEditingController();
  // final nameTextController = TextEditingController();
  // File? _selectedImage;

  // // Pick an image from the gallery
  // Future<void> pickImage() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //       _selectedImage = File(pickedFile.path);
  //     });
  //   }
  // }
  //
  // void addNewNote() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text("New Note"),
  //       content: Column(
  //         children: [
  //           TextField(
  //             controller: nameTextController,
  //
  //           ),
  //           TextField(
  //             decoration: InputDecoration(labelText: 'content'),
  //             controller: postTextController,
  //           ),
  //           _selectedImage == null
  //               ? ElevatedButton(
  //             onPressed: pickImage,
  //             child: const Text('Pick Image'),
  //           )
  //               : Image.file(_selectedImage!),
  //         ],
  //       ),
  //       actions: [
  //         //cencel button
  //         TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //               postTextController.clear();
  //               setState(() {
  //                 _selectedImage = null;
  //               });
  //             },
  //             child: Text('Cancel')),
  //         //save button
  //         TextButton(
  //           onPressed: () {
  //             //create a new note
  //             final newNote = Post(content: postTextController.text, name: nameTextController.text, image: _selectedImage!.toString());
  //
  //             // if (_selectedImage != null && postTextController.text.isNotEmpty) {
  //             //   await _post.insertPost(postTextController.text, _selectedImage!);
  //             //   Navigator.pop(context);
  //             //   postTextController.clear();
  //             //   setState(() {
  //             //     _selectedImage = null;
  //             //   });
  //             // } else {
  //             //   ScaffoldMessenger.of(context).showSnackBar(
  //             //     const SnackBar(content: Text('Please provide content and image')),
  //             //   );
  //             // }
  //
  //             //save in db
  //             _post.createNotes(newNote);
  //             Navigator.pop(context);
  //             postTextController.clear();
  //           },
  //           child: Text('Save'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // // user wants to post new message
  // // void postNewMessage() {
  // //   showDialog(
  // //     context: context,
  // //     builder: (context) => AlertDialog(
  // //       title: const Text("New Post"),
  // //       content: TextField(
  // //         controller: postTextController,
  // //       ),
  // //       actions: [
  // //         // cancel button
  // //         TextButton(
  // //           onPressed: () {
  // //             Navigator.pop(context);
  // //             postTextController.clear();
  // //           },
  // //           child: const Text("Cancel"),
  // //         ),
  // //
  // //         // post button
  // //         TextButton(
  // //           onPressed: () {
  // //             // post to supabase
  // //             _post.insertPost(postTextController.text);
  // //             Navigator.pop(context);
  // //             postTextController.clear();
  // //           },
  // //           child: const Text("Post"),
  // //         ),
  // //       ],
  // //     ),
  // //   );
  // // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Home",style: TextStyle(color: Colors.black)),
        actions: [

          // logout button
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage(),));
            },
            icon: const Icon(Icons.upload,color: Colors.black),
          )
        ],
      ),
      body: NewFeedPage(),
      // body: StreamBuilder(
      //   stream: _post.stream,
      //   builder: (context, snapshot) {
      //     // loading..
      //     if (!snapshot.hasData) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //
      //     // loaded
      //     final posts = snapshot.data!;
      //
      //     return ListView.builder(
      //       itemCount: 5,
      //       itemBuilder: (context, index) {
      //         // get each post
      //         final post = posts[index];
      //
      //         // list tile UI
      //         return NewFeedPage();
      //       },
      //     );
      //   },
      // ),
      // body:
      //   NewFeedPage(),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: addNewNote,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}