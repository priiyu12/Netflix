import 'package:flutter/material.dart';
import 'package:showbox/models/upcomingMovies.dart';
import '../common/utils.dart';

class MovieCardWidget extends StatelessWidget {
  final Future<UpcomingMovieModel> future;
  final String headLineText;

  const MovieCardWidget({super.key, required this.future, required this.headLineText});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UpcomingMovieModel>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display loading indicator while waiting for data
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Log the error to the console for debugging
          print('Error fetching movies: ${snapshot.error}');
          return Center(
            child: Text(
              'Error loading movies',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else if (snapshot.hasData) {
          var data = snapshot.data?.results;

          if (data == null || data.isEmpty) {
            return const Center(child: Text('No movies available'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headLineText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.network(
                        "$imageURL${data[index].posterPath}",
                        errorBuilder: (context, error, stackTrace) {
                          // Display placeholder image in case of error
                          return const Icon(Icons.broken_image);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          // Fallback for any unexpected cases
          return const Center(child: Text('Unexpected error'));
        }
      },
    );
  }
}
