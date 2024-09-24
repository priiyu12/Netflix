import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align items to the left
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), // Reduce vertical padding
              child: CupertinoSearchTextField(
                padding: const EdgeInsets.all(8), // Reduce padding inside the search bar
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
            Expanded( // Use Expanded to fill the remaining space
              child: searchModel == null
                  ? const Padding(
                padding: EdgeInsets.only(left: 10.0), // Reduce padding
                child: Text(
                  'Start searching by typing in the search bar above.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
                  : searchModel!.results.isEmpty
                  ? const Padding(
                padding: EdgeInsets.only(left: 10.0), // Reduce padding
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
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), // Add padding between items
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image on the left
                        imagePath != null
                            ? CachedNetworkImage(
                          imageUrl: imagePath,
                          height: 150, // Increased image height
                          width: 100, // Increased image width
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                          placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                        )
                            : const Icon(
                          Icons.image_not_supported,
                          size: 150, // Increased icon size
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 15), // Space between image and text

                        // Movie Name on the right
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                result.title ?? "No Title", // Display movie title
                                maxLines: 2, // Allow up to 2 lines for long titles
                                overflow: TextOverflow.ellipsis, // Truncate text if too long
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold), // Increased font size
                              ),
                              const SizedBox(height: 5), // Space between title and additional info
                              Text(
                                // Format the DateTime to a string in YYYY-MM-DD format
                                result.releaseDate != null
                                    ? DateFormat('yyyy-MM-dd').format(result.releaseDate)
                                    : "No Release Date", // Safely handle null values
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16, // Increased font size
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
