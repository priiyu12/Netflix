import 'package:flutter/material.dart';
import 'home_page.dart'; // Import the HomePage class

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Who\'s Watching?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileCard(
                  imagePath: 'assets/i4.png',
                  profileName: 'User 1',
                ),
                SizedBox(width: 20),
                ProfileCard(
                  imagePath: 'assets/i2.png',
                  profileName: 'User 2',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileCard(
                  imagePath: 'assets/i1.jpeg',
                  profileName: 'User 3',
                ),
                SizedBox(width: 20),
                ProfileCard(
                  imagePath: 'assets/i6.png',
                  profileName: 'User 4',
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Handle profile addition
              },
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
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String imagePath;
  final String profileName;

  ProfileCard({
    Key? key,
    required this.imagePath,
    required this.profileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
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
