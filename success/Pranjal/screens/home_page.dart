import 'package:flutter/material.dart';
import 'dart:ui'; // Required for the BackdropFilter
import 'help_page.dart'; // Import HelpPage
import 'about_us_screen.dart'; // Import AboutUsScreen
import 'profile_page.dart'; // Import ProfilePage

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent navigation back
        return Future.value(false);
      },
      child: Scaffold(
        // AppBar with custom text and settings button
        appBar: AppBar(
          // Remove default back button
          leading: SizedBox(),
          title: const Text(
            'Home Page',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24, // Adjust font size if needed
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 0,
          actions: [
            // Settings button in the top right corner
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white, size: 30),
              onPressed: () {
                _showSettingsDialog(context);
              },
            ),
          ],
        ),
        // Main content of the page
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background color
            Container(
              color: Colors.black,
            ),
            // Blurred effect with BackdropFilter
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            // Scrollable list of items
            ListView(
              children: [
                // Featured movies section
                Container(
                  height: 300,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildFeaturedMovieCard('assets/f1.jpeg', 'Movie 1'),
                      _buildFeaturedMovieCard('assets/f2.jpeg', 'Movie 2'),
                    ],
                  ),
                ),
                // Category sections
                _buildCategorySection(
                  context,
                  title: 'Trending Cartoons',
                  imagePaths: [
                    'assets/trending1.jpeg',
                    'assets/trending2.jpeg',
                    'assets/trending3.jpeg',
                    'assets/trending4.jpeg',
                  ],
                ),
                _buildCategorySection(
                  context,
                  title: 'Popular',
                  imagePaths: [
                    'assets/popular1.jpeg',
                    'assets/popular2.jpeg',
                    'assets/popular3.jpeg',
                    'assets/popular4.jpeg',
                  ],
                ),
                _buildCategorySection(
                  context,
                  title: 'Fighting',
                  imagePaths: [
                    'assets/fighting1.jpeg',
                    'assets/fighting2.jpeg',
                    'assets/fighting3.jpeg',
                    'assets/fighting4.jpeg',
                  ],
                ),
              ],
            ),
          ],
        ),
        // Bottom navigation bar
        bottomNavigationBar: SizedBox(
          height: 50,
          child: BottomAppBar(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Home button
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0), // Shift down
                  child: IconButton(
                    icon: const Icon(Icons.home, color: Colors.white, size: 30),
                    onPressed: () {
                      // Handle home action
                    },
                  ),
                ),
                // Search button
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0), // Shift down
                  child: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white, size: 30),
                    onPressed: () {
                      // Handle search action
                    },
                  ),
                ),
                // Notifications button
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0), // Shift down
                  child: IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white, size: 30),
                    onPressed: () {
                      // Handle notifications action
                    },
                  ),
                ),
                // Profile button
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0), // Shift down
                  child: IconButton(
                    icon: const Icon(Icons.person, color: Colors.white, size: 30),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfilePage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to show settings dialog
  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HelpPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutUsScreen()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Widget to build a featured movie card
  Widget _buildFeaturedMovieCard(String imagePath, String title) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          // Gradient overlay for text readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          // Title text centered on the card
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build a category section with a horizontal list of images
  Widget _buildCategorySection(BuildContext context, {required String title, required List<String> imagePaths}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Horizontal list of category items
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePaths[index]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
