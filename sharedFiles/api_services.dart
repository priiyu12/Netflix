import 'dart:convert';
import 'dart:developer';
import 'package:showbox/common/utils.dart';
import 'package:showbox/models/upcomingMovies.dart';
import 'package:http/http.dart' as http;
import '../models/top_rated_series_model.dart';

const baseUrl="https://api.themoviedb.org/3/";
var key="?api_key=$apiKey";
late String endPoint;

class ApiServices {
  Future<UpcomingMovieModel> getUpcomingMovies() async{
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint$key";

    final response=await http.get(Uri.parse(url));

    if(response.statusCode==200){
      log("Success");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Upcoming Movies Failed To Load");
  }

  Future<UpcomingMovieModel> getNowPlayingMovies() async{
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$key";

    final response=await http.get(Uri.parse(url));

    if(response.statusCode==200){
      log("Success");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Now Playing Movies Failed To Load");
  }

  Future<TopRatedSeriesModel> getTopRatedSeries() async{
    endPoint = "tv/top_rated";
    final url = "$baseUrl$endPoint$key";

    final response=await http.get(Uri.parse(url));

    if(response.statusCode==200){
      log("Success");
      return TopRatedSeriesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Top Rated Tv Series Failed To Load");
  }
}
