import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_app_supabase/feature/data/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/post_model.dart';

class PostService {
  // Database => note
  final supabase = Supabase.instance.client;
  final database = Supabase.instance.client.from('feed');
  final _auth = AuthService();
  final picker = ImagePicker();

  Future<void> insertPost(String content, File imageFile) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw 'User not authenticated';
    }

    try {
      // Upload image to Supabase storage
      final userId = user.id;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = 'upload/$userId/$fileName'; // Path within the bucket

      final uploadResponse = await supabase.storage.from('image').upload(path, imageFile);

      // Get the public URL for the uploaded image
      final imageUrl = supabase.storage.from('image').getPublicUrl(path);

      if (imageUrl == null) {
        throw 'Failed to retrieve image URL';
      }

      // Insert the post into the 'feed' table
      await supabase.from('feed').insert({
        'content': content,
        'image': imageUrl,
        'email': user.email,
      });
    } catch (e) {
      print('Error inserting post: $e');
      throw 'Failed to insert post: $e';
    }
  }

  // Future<void> insertPost(String content, File imageFile, ) async {
  //   final user = supabase.auth.currentUser;
  //   if (user == null) {
  //     throw 'User not authenticated';
  //   }
  //
  //   try {
  //     // Upload image to Supabase storage
  //     final userId = user.id;
  //     final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
  //     final path = '/$userId/upload/$fileName';
  //
  //     await supabase.storage.from('image').upload(path, imageFile);
  //
  //
  //     // Get the image URL after upload
  //     final imageUrl = supabase.storage.from('image').getPublicUrl(path).toString();
  //     if (imageUrl == null) {
  //       throw 'Failed to retrieve image URL';
  //     }
  //     // await _supabase.from('image').update({'image':imageUrl}).eq('id', userId);
  //     // Insert the post into the 'feed' table
  //     await supabase.from('feed').insert({
  //
  //       'content': content,
  //       'image': imageUrl,
  //       // 'user_id': user.id,
  //       'email': user.email,
  //     });
  //   } catch (e) {
  //     print('User ID: ${user.id}');
  //     print('Content: $content');
  //     // print('Image URL: $imageUrl');
  //
  //     print(e);
  //     throw 'Failed to insert post: $e';
  //   }
  // }

  final stream = Supabase.instance.client
      .from('feed')
      .stream(primaryKey: ['id'])
      .map((data) {
    return data.map((noteMap) => Post.fromMap(noteMap)).toList();
  });


  //create
  Future createNotes(Post post) async {
    await database.insert(post.toMap());
  }

  //read
  // final stream = Supabase.instance.client.from('feed').stream(
  //   primaryKey: ['id'],
  // ).map((data) => data.map((noteMap) => Post.fromMap(noteMap)).toList());

  //update
  Future updateNote(Post oldPost, String newContent) async {
    await database.update({'content': newContent}).eq('id', oldPost.id!);
  }

//delete
  Future daleteNote(Post post) async {
    await database.delete().eq('id', post.id!);
  }
}
