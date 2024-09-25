import 'package:flutter/material.dart';
import 'package:showbox/screens/homescreen.dart';
// Import the HomePage class

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Map<String, String>> profiles = [];

  final List<String> additionalImages = [
    'assets/i3.jpeg',
    'assets/i4.png',
  ];

  @override
  void initState() {
    super.initState();
    _loadProfiles();
  }

  Future<void> _loadProfiles() async {
    setState(() {
      profiles = [
        {'imagePath': 'assets/i1.jpeg', 'profileName': 'Kids'},
      ];
    });
  }

  void _addProfile(String name) {
    if (profiles.length >= 3) {
      _showErrorDialog();
      return;
    }

    setState(() {
      String imagePath = additionalImages[profiles.length - 1];
      profiles.add({'imagePath': imagePath, 'profileName': name});
    });
  }

  Future<void> _showAddProfileDialog() async {
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
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (newName.isNotEmpty) {
                  _addProfile(newName);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('You can only add up to 3 profiles.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profiles',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // List of profile cards
              Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: profiles
                    .map((profile) => ProfileCard(
                  imagePath: profile['imagePath']!,
                  profileName: profile['profileName']!,
                ))
                    .toList(),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _showAddProfileDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Add Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String imagePath;
  final String profileName;

  const ProfileCard({
    super.key,
    required this.imagePath,
    required this.profileName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavBar()),
        );
      },
      child: Column(
        children: [
          Container(
            width: 120, // Size of the square
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle, // Use rectangle shape
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            profileName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold, // Make text bold
            ),
          ),
        ],
      ),
    );
  }
}