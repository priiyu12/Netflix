import 'dart:convert';
import 'dart:developer';

import 'package:showbox/common/utils.dart';
import 'package:http/http.dart' as http;
import '../models/upcoming_movie_model.dart';

const baseUrl = "https://api.themoviedb.org/3/";
const key = "?api_key=$apiKey";
late String endPoint;

class ApiServices{
  Future<UpcomingMovieModel> getUpcomingMovies() async {
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      log("Success");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load upcoming movies");
  }
}