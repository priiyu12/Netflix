import 'package:flutter/material.dart';
import 'package:showbox/common/utils.dart';
import 'package:showbox/models/top_rated_series_model.dart';
import 'package:showbox/models/upcomingMovies.dart';
import 'package:showbox/widgets/movie_card_widget.dart';
import '../services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovieModel> upcomingFuture;
  late Future<UpcomingMovieModel> nowPlayingFuture;
  late Future<TopRatedSeriesModel> topRatedSeries;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final apiService = ApiServices(); // Create an instance of ApiServices
    upcomingFuture = apiService.getUpcomingMovies();
    nowPlayingFuture = apiService.getNowPlayingMovies();
    topRatedSeries = apiService.getTopRatedSeries();
  }

  // List of widgets to display in the body for each tab
  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text("Home Screen Content")),
    Center(child: Text("Search Screen Content")),
    Center(child: Text("New & Hot Screen Content")),
    Center(child: Text("Settings Screen Content")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgorundColor,
        title: Image.asset(
          "assets/logo.png",
          height: 120,
          width: 140,
          alignment: Alignment.centerLeft,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                // Add search functionality
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
            child: Container(
              color: Colors.blue, // Replace this with user profile image
              height: 27,
              width: 27,
              // Example for loading a user profile image
              // child: Image.asset("assets/profile.png", fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: _selectedIndex == 0
          ? SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: FutureBuilder<UpcomingMovieModel>(
                future: nowPlayingFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Failed to load now playing movies'),
                    );
                  } else if (snapshot.hasData) {
                    return MovieCardWidget(
                      future: nowPlayingFuture,
                      headLineText: 'Now Playing Movies',
                    );
                  } else {
                    return Center(child: Text('No data available'));
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 220,
              child: FutureBuilder<UpcomingMovieModel>(
                future: upcomingFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Failed to load upcoming movies'),
                    );
                  } else if (snapshot.hasData) {
                    return MovieCardWidget(
                      future: upcomingFuture,
                      headLineText: 'Upcoming Movies',
                    );
                  } else {
                    return Center(child: Text('No data available'));
                  }
                },
              ),
            ),
          ],
        ),
      )
          : _widgetOptions.elementAt(_selectedIndex),
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
