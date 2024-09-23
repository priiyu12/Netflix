import 'package:flutter/material.dart';
import 'package:showbox/widgets/bottom_nav_bar.dart';

class SeachScreen extends StatefulWidget {
  const SeachScreen({super.key});

  @override
  State<SeachScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SeachScreen> {
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
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body : const Center(
          child: Text("Hi, I'm Search Screen")
      ),
    );
  }
}
