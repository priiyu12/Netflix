import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:showbox/common/utils.dart';
import 'package:http/http.dart' as http;
import 'package:showbox/models/search_model.dart';
import '../models/top_rated_tv_series.dart';
import '../models/upcoming_movie_model.dart';

// API base URL
const baseUrl = "https://api.themoviedb.org/3/";
// API key
const key = "?api_key=$apiKey";
// Base image URL for loading images from TMDB
const imageUrl = "https://image.tmdb.org/t/p/w500";

late String endPoint;

class ApiServices {
  // Fetch upcoming movies
  Future<UpcomingMovieModel> getUpcomingMovies() async {
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success: Upcoming Movies Fetched");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load upcoming movies");
  }

  // Fetch now playing movies
  Future<UpcomingMovieModel> getNowPlayingMovie() async {
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success: Now Playing Movies Fetched");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load now playing movies");
  }

  // Fetch top-rated TV series
  Future<TopRatedTvSeries> getTopRatedTvSeries() async {
    endPoint = "tv/top_rated";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success: Top Rated TV Series Fetched");
      return TopRatedTvSeries.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load top-rated TV series");
  }

  // Search for a movie or TV show
  Future<SearchModel> getSearchMovie(String searchText) async {
    endPoint = "search/tv?query=$searchText";
    final url = "$baseUrl$endPoint$key";

    if (kDebugMode) {
      print("Search URL: $url");
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1OWQ0NmE2NGM5OWQzNjQwYTgxYzdiNTBiOGZiOTNmMCIsIm5iZiI6MTcyNzEwMDIwMy41Mzg0OTUsInN1YiI6IjY2YjBhZWNhNzQ0M2YyNzk3OWJkZDZlZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1lTrBapKQZ3egFJeybU_jWG_4P4xsq7YsRnIoLo9orY",
      },
    );

    if (response.statusCode == 200) {
      log("Success: Search Results Fetched");
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load search results");
  }
}
