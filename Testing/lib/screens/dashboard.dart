import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final String userName;

  const DashboardScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $userName'),
      ),
      body: Center(
        child: Text(
          'Dashboard for $userName',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
