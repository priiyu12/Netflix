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
      title: 'ShowBox',//SHOW TITLE OF APP
      themeMode: ThemeMode.dark,//SET THEME MODE
      debugShowCheckedModeBanner: false,//HIDE DEBUG BANNER ON TOP RIGHT
      theme: ThemeData(
        useMaterial3: true, //USE MATERIAL DESIGN3
      ),
      home: const IntroVideoScreen(), // Starting screen
    );
  }
}
