import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:showbox/common/utils.dart';
import 'package:http/http.dart' as http;
import 'package:showbox/models/movie_detailed_model.dart';
import 'package:showbox/models/movie_recommendation_model.dart';
import 'package:showbox/models/movie_trailer_model.dart';
import 'package:showbox/models/search_model.dart';
import '../models/top_rated_tv_series.dart';
import '../models/tv_recommendation_model.dart';
import '../models/tv_series_detailed_model.dart';
import '../models/upcoming_movie_model.dart';

const baseUrl = "https://api.themoviedb.org/3/";
const key = "?api_key=$apiKey";
late String endPoint;

class ApiServices {
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

  Future<SearchModel> getSearchMovie(String searchText) async {
    endPoint = "search/movie?query=$searchText";
    final url = "$baseUrl$endPoint";

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

  Future<MovieRecommendationsModel> getPopularMovies() async {
    endPoint = "movie/popular";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success: Top Rated TV Series Fetched");
      return MovieRecommendationsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load movie recommendation");
  }

  Future<MovieDetailedModel> getMovieDetail(int movieId) async {
    endPoint = 'movie/$movieId';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success');
      return MovieDetailedModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load  movie details');
  }

  Future<MovieRecommendationsModel> getMovieRecommendations(int movieId) async {
    endPoint = 'movie/$movieId/recommendations';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success');
      return MovieRecommendationsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load  movie details');
  }
  Future<TvSeriesDetailedModel> getTvSeriesDetail(int seriesId) async {
    endPoint = 'tv/$seriesId';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log('Success: TV Series Details Fetched');
      return TvSeriesDetailedModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load TV series details');
    }
  }

  Future<TvRecommendationsModel> getTvRecommendations(int seriesId) async {
    endPoint = 'tv/$seriesId/recommendations';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log('Success: TV Series Recommendations Fetched');
      return TvRecommendationsModel.fromJson(jsonDecode(response.body)); // Ensure the model class is correct
    }
    throw Exception('Failed to load TV series recommendations');
  }

  Future<MovieTrailerModel> getMovieTrailer(int movieId) async {
    endPoint = 'movie/$movieId/videos';
    String lan = "?language=en-US&api_key=59d46a64c99d3640a81c7b50b8fb93f0";
    final url = '$baseUrl$endPoint$lan';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log('Success: TV Series Details Fetched');
      return MovieTrailerModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load TV series details');
    }
  }

}
