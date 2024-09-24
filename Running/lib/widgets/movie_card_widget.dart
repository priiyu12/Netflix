import 'package:flutter/material.dart';
import 'package:showbox/common/utils.dart';
import 'package:showbox/models/upcoming_movie_model.dart';

class MovieCardWidget extends StatelessWidget {
  final Future<UpcomingMovieModel> future;
  final String headLineText;

  const MovieCardWidget({
    super.key, required this.future, required this.headLineText
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UpcomingMovieModel>(
      future: future,
      builder: (context, snapshot) {
        // Debugging: Check the connection state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // Get the data from the snapshot
        var data = snapshot.data?.results;
        print("Data Results: $data");

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                headLineText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: data?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var movie = data?[index];

                  // Debugging: Print each movie's details
                  print("Movie: ${movie?.title}, Poster Path: ${movie?.posterPath}");

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        "$imageUrl${movie?.posterPath}",
                        fit: BoxFit.cover,
                        width: 150,
                        errorBuilder: (context, error, stackTrace) => const Center(
                          child: Text("Failed to load image"),
                        ), // Add error handling for image loading
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
