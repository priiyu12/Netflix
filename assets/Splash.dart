import 'package:flutter/material.dart';
import 'package:netflix/screens/username.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _firstAnimation;
  Animation<double>? _secondAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _firstAnimation = CurvedAnimation(
      parent: _controller!,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    );

    _secondAnimation = CurvedAnimation(
      parent: _controller!,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    );

    _controller!.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserName()),
      );
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Stack(
            children: [
              FadeTransition(
                opacity: _firstAnimation!,
                child: Image.asset(
                  'assets/images/S.jpg',
                  width: 200,
                  height: 200,
                ),
              ),
              FadeTransition(
                opacity: _secondAnimation!,
                child: Image.asset(
                  'assets/images/SB.jpg',
                  width: 200,
                  height: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
