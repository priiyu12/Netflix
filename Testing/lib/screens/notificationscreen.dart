import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final String notification;

  NotificationScreen({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Text(notification),
      ),
    );
  }
}
