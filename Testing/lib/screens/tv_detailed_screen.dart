import 'package:flutter/material.dart';
import '../common/utils.dart'; // Ensure this file exists
import '../models/movie_detailed_model.dart';
import '../services/api_services.dart';

class TvDetailedScreen extends StatefulWidget {
  final int seriesId;
  const TvDetailedScreen({super.key, required this.seriesId});

  @override
  State<TvDetailedScreen> createState() => _TvDetailedScreenState();
}

class _TvDetailedScreenState extends State<TvDetailedScreen> {
  late int seriesId;
  ApiServices apiServices = ApiServices();
  late Future<MovieDetailedModel> tvDetail;

  // Base URL for fetching images
  final String imageUrl = "https://image.tmdb.org/t/p/w500";

  @override
  void initState() {
    seriesId = widget.seriesId;
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    tvDetail = apiServices.getMovieDetail(seriesId);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<MovieDetailedModel>(
        future: tvDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for data
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle errors
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            // Once data is fetched, display the details including the image
            var movie = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Poster Image
                  Container(
                    height: size.height * 0.6, // 60% of screen height
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("$imageUrl${movie.posterPath}"),
                        fit: BoxFit.cover, // Adjust the fit to cover the entire area
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Movie Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      movie.title, // Movie title from the fetched data
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Movie Overview
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      movie.overview, // Movie description
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // In case no data is returned
            return const Center(child: Text("No details available"));
          }
        },
      ),
    );
  }
}
