import 'package:flutter/material.dart';
import 'package:showbox/screens/about_us_screen.dart';
import 'package:showbox/screens/help_page.dart';
import 'package:showbox/screens/login_screen.dart';
import 'package:showbox/screens/profile_page.dart';
import 'package:showbox/widgets/bottom_nav_bar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingScreen> {
  bool _isDarkMode = false; // For Theme Mode
  String _videoQuality = 'Medium'; // For Video Quality

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          'assets/logo.png',
          height: 50,
          width: 120,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavBar(),
                  ),
                );
              },
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: InkWell(
              onTap: () {},
              child: Container(
                color: Colors.blue,
                height: 27,
                width: 27,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text(
              'Theme Mode',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            subtitle: Text(
              _isDarkMode ? 'Dark Mode' : 'Light Mode',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            value: _isDarkMode,
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
                // Logic to change app theme can be added here
              });
            },
          ),
          ListTile(
            title: const Text(
              'Video Quality',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            subtitle: Text(
              _videoQuality,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onTap: () {
              _showVideoQualityDialog();
            },
          ),
          ListTile(
            title: const Text(
              'Manage Profile',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(), // Navigate to About Us screen
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              'About Us',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutUsScreen(), // Navigate to About Us screen
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Help Us',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HelpPage(), // Navigate to Help Us screen
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Log Out',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onTap: () {
              // Implement log out functionality, then navigate to Login screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(), // Navigate to Login screen
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showVideoQualityDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Video Quality', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white, // Dialog background color
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Low', style: TextStyle(color: Colors.black)),
                onTap: () {
                  setState(() {
                    _videoQuality = 'Low';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Medium', style: TextStyle(color: Colors.black)),
                onTap: () {
                  setState(() {
                    _videoQuality = 'Medium';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('High', style: TextStyle(color: Colors.black)),
                onTap: () {
                  setState(() {
                    _videoQuality = 'High';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
