import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
        backgroundColor: Colors.red, // Customize the color as needed
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Welcome to the Help Page!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Here you can find answers to commonly asked questions and get assistance with using the app.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            ListTile(
              title: const Text('Contact Support'),
              onTap: () {
                // Add your logic for "Contact Support" here
              },
            ),
            ListTile(
              title: const Text('FAQs'),
              onTap: () {
                // Add your logic for "FAQs" here
              },
            ),
          ],
        ),
      ),
    );
  }
}
