import 'package:flutter/material.dart';
import 'package:showbox/screens/homescreen.dart';
import 'package:showbox/screens/login_screen.dart';
import 'package:video_player/video_player.dart';

class IntroVideoScreen extends StatefulWidget {
  const IntroVideoScreen({super.key});

  @override
  _IntroVideoScreenState createState() => _IntroVideoScreenState();
}


class _IntroVideoScreenState extends State<IntroVideoScreen> {
  late VideoPlayerController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.asset('assets/astreamingplatform.mp4')
      ..initialize().then((_) {
        setState(() {
          _isLoading = false;
        });
        _controller.play();
      });

    _controller.setLooping(false);
    _controller.addListener(() {
      if (!_controller.value.isPlaying &&
          _controller.value.isInitialized &&
          (_controller.value.duration == _controller.value.position)) {
        _navigateToLogin();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()), //NAVIGATE TO LOG IN SCREEN
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}