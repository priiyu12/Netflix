import 'package:flutter/material.dart';
import 'dart:ui'; // Required for the BackdropFilter

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black, // Ensures the AppBar background is black
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30), // Back arrow
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white, size: 30), // Home icon
            onPressed: () {
              // Handle home action
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 30), // Search icon
            onPressed: () {
              // Handle search action
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white, size: 30), // Notifications icon
            onPressed: () {
              // Handle notifications action
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Black Background
          Container(
            color: Colors.black, // Solid black background
          ),
          // Blur Effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0.4), // Semi-transparent overlay
            ),
          ),
          // Main Content
          ListView(
            children: [
              // Featured Movies Section
              Container(
                height: 300,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFeaturedMovieCard('assets/f1.jpeg', 'Movie 1'),
                    _buildFeaturedMovieCard('assets/f2.jpeg', 'Movie 2'),
                    // Add more featured movie cards here if needed
                  ],
                ),
              ),
              // Category: Trending Carttons
              _buildCategorySection(
                context,
                title: 'Trending Carttons',
                imagePaths: [
                  'assets/trending1.jpeg',
                  'assets/trending2.jpeg',
                  'assets/trending3.jpeg',
                  'assets/trending4.jpeg',
                ],
              ),
              // Category: Popular
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
              // Category: Fighting
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
              // Add more categories as needed
            ],
          ),
        ],
      ),
    );
  }

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
          // Gradient overlay to ensure text is readable
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
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White color for text
                backgroundColor: Colors.black.withOpacity(0.4), // Semi-transparent background for text
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, {required String title, required List<String> imagePaths}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Change text color to white
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200, // Height of the image container
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                width: 120, // Width of the image container
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
