import 'package:flutter/material.dart';
import 'package:media_app_supabase/feature/data/auth_service.dart';

import '../../screen/home_page.dart';
import '../../screen/profile/profile_page.dart';
import 'my_drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // backgroundColor: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              //logo
              const Icon(
                Icons.person,
                size: 80,
                color: Colors.black,
              ),
              const Divider(),

              // Home
              MyDrawerTile(
                title: 'Home',
                icon: Icons.home_filled,
                opTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false, // This will remove all previous routes
                  );
                },
              ),

              // Profile
              MyDrawerTile(
                  title: 'Profile',
                  icon: Icons.person,
                  opTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ));
                  }),

              // Search
              MyDrawerTile(
                title: 'Search',
                icon: Icons.search,
                opTap: () {
                  Navigator.pop(context);
                },
              ),

              // Setting
              MyDrawerTile(
                title: 'Setting',
                icon: Icons.settings,
                opTap: () {
                  Navigator.pop(context);
                },
              ),

              const Spacer(),

              // Log out
              MyDrawerTile(
                title: 'Log out',
                icon: Icons.logout,
                opTap: () {
                  _auth.signOut();
                },
                // opTap: () {
                //   context.read<AuthCubit>().logout();
                //
                //   // Optionally navigate to the login screen after logging out
                //   Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(builder: (context) => const HomePage()), // Update to LoginPage if needed
                //         (route) => false,
                //   );
                // },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
