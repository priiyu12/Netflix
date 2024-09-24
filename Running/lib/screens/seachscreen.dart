import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:showbox/models/search_model.dart';
import 'package:showbox/services/api_services.dart';

const imageUrl = "https://image.tmdb.org/t/p/w500"; // Base image URL

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();

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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView( // Wrap with SingleChildScrollView
          child: Column(
            children: [
              // Search bar
              CupertinoSearchTextField(
                padding: const EdgeInsets.all(10),
                controller: searchController,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 30,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  size: 30,
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
              // Conditional rendering based on search results
              if (searchModel == null)
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Start searching by typing in the search bar above.',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              else if (searchModel!.results.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'No results found',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              else
                SizedBox(
                  height: MediaQuery.of(context).size.height, // Ensure height
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 5,
                      childAspectRatio: 1.2 / 2,
                    ),
                    itemCount: searchModel!.results.length,
                    itemBuilder: (context, index) {
                      final result = searchModel!.results[index];
                      final imagePath = result.backdropPath != null
                          ? "$imageUrl${result.backdropPath}"
                          : null;

                      return Column(
                        children: [
                          imagePath != null
                              ? CachedNetworkImage(
                            imageUrl: imagePath,
                            height: 170,
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            placeholder: (context, url) => const CircularProgressIndicator(),
                          )
                              : const Icon(
                            Icons.image_not_supported,
                            size: 170,
                            color: Colors.grey,
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
