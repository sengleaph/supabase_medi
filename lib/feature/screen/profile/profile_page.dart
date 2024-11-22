import 'package:flutter/material.dart';

import '../../data/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // get auth service
  final _auth = AuthService();

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // get current user email
    String currentUserEmail = _auth.getCurrentUserEmail() ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Column(
          children: [
            // profile pic
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(25),
              child: const Icon(
                Icons.person,
                size: 100,
              ),
            ),

            const SizedBox(height: 25),

            // email
            Text(currentUserEmail),
          ],
        ),
      ),
    );
  }
}