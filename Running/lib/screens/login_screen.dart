import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'sign_up_screen.dart';
import 'profile_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // Key to manage form state
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        // Retrieve user profiles from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        List<Map<String, String>> profiles = [];

        if (userDoc.exists) {
          // Cast the document data to Map<String, dynamic>
          Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

          if (userData != null && userData.containsKey('profiles')) {
            List<dynamic>? storedProfiles = userData['profiles'] as List<dynamic>?;
            if (storedProfiles != null) {
              profiles = List<Map<String, String>>.from(
                storedProfiles.map((profile) => Map<String, String>.from(profile)),
              );
            }
          } else {
            // If no profiles exist, initialize with a kids profile
            profiles = [{'name': 'Kids', 'image': 'assets/i1.jpeg'}];
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .update({'profiles': profiles});
          }
        }

        // Navigate to ProfilePage with the retrieved profiles
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(profiles: profiles),
          ),
        );
      }
    } catch (e) {
      print('Error signing in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/home-bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 250,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email or mobile number',
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.7),
                          hintStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email or mobile number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.7),
                          hintStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200, // Set the desired width here
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _signIn();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()),
                          );
                        },
                        child: const Text(
                          'New to ShowBox? Sign up now.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}