import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:showbox/screens/homescreen.dart';

class ProfilePage extends StatefulWidget {
  final List<Map<String, String>> profiles;

  const ProfilePage({Key? key, required this.profiles}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Map<String, String>> profiles = [];
  bool isEditing = false; // Toggle for editing mode (showing cross icons)

  // Updated profile images for each profile
  final List<String> profileImages = [
    'assets/i3.jpeg', // First profile
    'assets/i4.png',  // Second profile
    'assets/i6.png',  // Third profile
  ];

  @override
  void initState() {
    super.initState();
    profiles = widget.profiles.isEmpty
        ? [
      {'name': 'Kids', 'image': 'assets/i1.jpeg'}, // Kids profile
    ]
        : widget.profiles;
  }

  // Function to delete a profile
  Future<void> _deleteProfile(int index) async {
    setState(() {
      profiles.removeAt(index); // Remove profile locally
    });

    // Delete the profile from Firestore
    await _updateFirestoreProfiles();
  }

  // Function to add a new profile
  Future<void> _addProfile(String profileName) async {
    if (profiles.length >= 4) {
      // Maximum 4 profiles total (including Kids profile)
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Limit Reached'),
          content: const Text('You can only add up to 4 profiles, including the Kids profile.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Determine the image for the new profile based on the current count
    String newImage = '';
    if (profiles.length == 1) {
      newImage = profileImages[0]; // Profile 1
    } else if (profiles.length == 2) {
      newImage = profileImages[1]; // Profile 2
    } else if (profiles.length == 3) {
      newImage = profileImages[2]; // Profile 3
    } else {
      // Fallback in case of unexpected states
      newImage = 'assets/default.png'; // Set a default image or handle error
    }

    setState(() {
      profiles.add({'name': profileName, 'image': newImage});
    });

    // Update Firestore with the new profile
    await _updateFirestoreProfiles();
  }

  // Function to update Firestore with the profiles
  Future<void> _updateFirestoreProfiles() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'profiles': profiles});
    }
  }

  // Toggle edit mode (show/hide delete cross icons)
  void _toggleEditing() {
    setState(() {
      isEditing = !isEditing; // Toggle edit mode
    });
  }

  // Navigate to BottomNavBar on profile selection
  void _onProfileSelected(String profileName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavBar(profiles: []), // Navigate to BottomNavBar
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Profiles',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(isEditing ? Icons.done : Icons.edit), // Toggle pencil and checkmark
            onPressed: _toggleEditing, // Toggle edit modes
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          // Showbox logo (use your actual image asset here)
          Image.asset(
            'assets/logo.png', // Replace with your actual logo asset
            height: 60,
          ),
          const SizedBox(height: 20),
          const Text(
            "Who's Watching?",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2x2 grid
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.8, // Adjust for larger images
              ),
              itemCount: profiles.length + (profiles.length < 4 ? 1 : 0), // Show + button if profiles < 4
              itemBuilder: (context, index) {
                if (index < profiles.length) {
                  // Existing profile display
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!isEditing) {
                            _onProfileSelected(profiles[index]['name']!); // Handle profile selection
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 120, // Larger square size
                              width: 120,  // Larger square size
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(profiles[index]['image']!),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.rectangle, // Square shape
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              profiles[index]['name']!,
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      if (isEditing)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              _deleteProfile(index); // Delete profile
                            },
                          ),
                        ),
                    ],
                  );
                } else {
                  // + button to add a new profile
                  return GestureDetector(
                    onTap: () async {
                      String newName = '';
                      await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Add Profile'),
                            content: TextField(
                              onChanged: (value) {
                                newName = value;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter profile name',
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  if (newName.isNotEmpty) {
                                    _addProfile(newName); // Add the new profile
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Add'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey[800], // Background for + button
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(Icons.add, color: Colors.white, size: 48),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Add Profile',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
