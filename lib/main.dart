import 'package:flutter/material.dart';
import 'package:media_app_supabase/feature/screen/auth/auth_gate.dart';
import 'package:media_app_supabase/feature/screen/home_page.dart';
import 'package:media_app_supabase/feature/screen/new_feed/newfeed_page.dart';
import 'package:media_app_supabase/feature/screen/post/post_page.dart';
import 'package:media_app_supabase/feature/utils/component/slashscreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
      url: "https://fjrvlzictvlfdzjmwuwk.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZqcnZsemljdHZsZmR6am13dXdrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIwMjU3ODEsImV4cCI6MjA0NzYwMTc4MX0.M3v8L3EiBeGsqgNut0iI4J8muu17MyAIENZ_XmY740U");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
