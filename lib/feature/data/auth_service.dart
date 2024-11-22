import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {

  final _supabase = Supabase.instance.client;
// ===========================>>> AUTH <<<====================================
  // Sign in with email & password
  Future signInWithEmailPassword(String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign up with email & password
  Future signUpWithEmailPassword(String name, String email, String password) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  // Sign up
  Future signOut() async {
    return await _supabase.auth.signOut();
  }

  // Get current user email
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  // Get current user's name (if available from the profile)
  Future<String?> getCurrentUserName() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      return null;
    }

    // Fetch user data from the Supabase 'profiles' table (or wherever the name is stored)
    final response = await _supabase
        .from('profiles') // Replace 'profiles' with your actual table name
        .select('name')
        .eq('id', user.id)
        .single();
    // return response.;
  }
}