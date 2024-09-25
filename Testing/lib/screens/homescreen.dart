import 'package:flutter/material.dart';
import 'package:showbox/models/top_rated_tv_series.dart';
import 'package:showbox/models/upcoming_movie_model.dart';
import 'package:showbox/screens/seachscreen.dart';
import 'package:showbox/screens/settings.dart';
import 'package:showbox/services/api_services.dart';
import 'package:showbox/widgets/custom_carousel.dart';
import 'package:showbox/widgets/movie_card_widget.dart';

import 'newhotscreen.dart';
import 'notificationscreen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchScreen(),
    MoreScreen(),
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 35,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_library_outlined,
              size: 35,
            ),
            label: 'New & Hot',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 35,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovieModel> upcomingFuture;
  late Future<UpcomingMovieModel> nowPlayingFuture;
  late Future<TopRatedTvSeries> topRatedSeries;
  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    upcomingFuture = apiServices.getUpcomingMovies();
    nowPlayingFuture = apiServices.getNowPlayingMovie();
    topRatedSeries = apiServices.getTopRatedTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Image.asset(
          "assets/logo.png", // Ensure the asset exists
          height: 120,
          width: 140,
          alignment: Alignment.centerLeft,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    String notificationMessage = "Welcome! You have 3 new notifications.";
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationScreen(notification: notificationMessage),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.notifications,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                // Display red dot for new notifications
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: Colors.blue, // Placeholder for profile image
              height: 27,
              width: 27,
              // Use Image.network or AssetImage for actual profile image
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: topRatedSeries,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(  // Allows scrolling if content is too big
                    child: SizedBox(
                      height: 300, // Set your desired height
                      child: CustomCarousel(data: snapshot.data!),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            SizedBox(
              height: 300,
              child: MovieCardWidget(
                  future: nowPlayingFuture,
                  headLineText: "Now Playing Movies"
              ),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              height: 300,
              child: MovieCardWidget(
                  future: upcomingFuture,
                  headLineText: "Upcoming Movies"
              ),
            )
          ],
        ),
      ),
    );
  }
}