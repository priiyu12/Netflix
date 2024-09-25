import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:showbox/models/movie_recommendation_model.dart';
import 'package:showbox/models/search_model.dart';
import 'package:showbox/services/api_services.dart';

const imageUrl = "https://image.tmdb.org/t/p/w500";

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  late Future<MovieRecommendationModel> popularMovies;
  SearchModel? searchModel;

  // Function to search for movies or TV shows
  void search(String query) {
    apiServices.getSearchMovie(query).then((results) {
      if (kDebugMode) {
        print("Search Results: ${results.toJson()}"); // Log the results
      }
      setState(() {
        searchModel = results;
      });
    }).catchError((error) {
      if (kDebugMode) {
        print("Error: $error");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    popularMovies = apiServices.getPopularMovies();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: CupertinoSearchTextField(
                padding: const EdgeInsets.all(8),
                controller: searchController,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 25,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  size: 25,
                  color: Colors.grey,
                ),
                style: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      searchModel = null;
                    });
                  } else {
                    search(searchController.text);
                  }
                },
              ),
            ),

            // Conditional rendering based on search results
            Expanded(
              child: searchModel == null
                  ? FutureBuilder<MovieRecommendationModel>(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var data = snapshot.data?.results;
                  print("Data Results: $data");

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Top Searches:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: data?.length,
                          scrollDirection: Axis.vertical, // Changed to vertical
                          itemBuilder: (context, index) {
                            var movie = data?[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: Row(
                                children: [
                                  // Movie image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: "$imageUrl${movie?.posterPath}",
                                      width: 100,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                      placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                    ),
                                  ),
                                  const SizedBox(width: 15), // Space between image and name

                                  // Movie title
                                  Expanded(
                                    child: Text(
                                      movie?.title ?? "No Title",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              )
                  : searchModel!.results.isEmpty
                  ? const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'No results found',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: searchModel!.results.length,
                itemBuilder: (context, index) {
                  final result = searchModel!.results[index];
                  final imagePath = result.backdropPath != null
                      ? "$imageUrl${result.backdropPath}"
                      : null;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image on the left
                        imagePath != null
                            ? CachedNetworkImage(
                          imageUrl: imagePath,
                          height: 150,
                          width: 100,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                          placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                        )
                            : const Icon(
                          Icons.image_not_supported,
                          size: 100,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 15),

                        // Movie Name on the right
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                result.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                result.releaseDate != null
                                    ? DateFormat('yyyy-MM-dd')
                                    .format(result.releaseDate)
                                    : "No Release Date",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
