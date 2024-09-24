import 'package:flutter/material.dart';
import 'package:showbox/screens/homescreen.dart';
import 'package:video_player/video_player.dart';

class IntroVideoScreen extends StatefulWidget {
  const IntroVideoScreen({super.key});

  @override
  _IntroVideoScreenState createState() => _IntroVideoScreenState();
}


class _IntroVideoScreenState extends State<IntroVideoScreen> {
  late VideoPlayerController _controller; //CONTROLLER THAT HANDLE PLAYBACK OF VIDEO
  bool _isLoading = true;// SHOWS LOADING SYMBOL

  @override
  void initState() {
    super.initState();
    _initializeVideo(); //INITIALIZE THE VIDEO PLAYER WHEN STATE IS CREATED
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.asset('assets/astreamingplatform.mp4') // PATH OF VIDEO TO LOAD
      ..initialize().then((_) {
        setState(() {
          _isLoading = false; //UPADETE LODING SYMBOL TO INITIALIZE WHEN VIDEO RUN
        });
        _controller.play(); // PHASE TO START VIDEO
      });

    _controller.setLooping(false); //CHECK THE VIDEO DOESNT GO IN LOOP
    _controller.addListener(() {
      //CHECK IF VIDEO HAS ENDED AND NEVIGATE TO LOGIN SCREEN
      if (!_controller.value.isPlaying &&
          _controller.value.isInitialized &&
          (_controller.value.duration == _controller.value.position)) {
        _navigateToLogin();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // DISPOSE VIDEO CONTROLLER WHEN WIDJETS IS REMOVED
    super.dispose();
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const BottomNavBar()), //NAVIGATE TO LOG IN SCREEN
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, //BACKGROUND COLOR OF SCREEN
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator() //LOADING SYMBOL WHILE VIDEO IS LOADING
            : AspectRatio(
          aspectRatio: _controller.value.aspectRatio, //MAINTAIN ASPECT RADIO OF VIDEO
          child: VideoPlayer(_controller), //DISPLAY VIDEO WIDGETS
        ),
      ),
    );
  }
}