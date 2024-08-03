import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showbox/screens/login_screen.dart';
import 'package:showbox/screens/profile_page.dart';
import 'package:showbox/screens/intro_video.dart';
import 'package:showbox/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShowBox',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, // Keep the primary color from the first app
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 24),
          bodyMedium: TextStyle(color: Colors.white, fontSize: 20),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(surface: Colors.black),
        fontFamily: GoogleFonts.ptSans().fontFamily,
        useMaterial3: true,
      ),
      home: const IntroVideoScreen(), // Starting screen
    );
  }
}
