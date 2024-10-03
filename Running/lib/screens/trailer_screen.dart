import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart'; // For controlling orientation
import '../services/api_services.dart';
import '../models/movie_trailer_model.dart';

class TrailerScreen extends StatefulWidget {
  final int movieId;

  const TrailerScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  _TrailerScreenState createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  late YoutubePlayerController _controller;
  final ApiServices _apiServices = ApiServices();
  String? trailerKey;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTrailer();
  }

  Future<void> fetchTrailer() async {
    try {
      MovieTrailerModel trailerData = await _apiServices.getMovieTrailer(widget.movieId);
      // Get the first official trailer from YouTube
      Result? officialTrailer = trailerData.results.firstWhere(
            (result) => result.site == "YouTube" && result.type == "Trailer" && result.official == true,
        orElse: () => trailerData.results[0], // Fallback to the first result if no official trailer
      );

      setState(() {
        trailerKey = officialTrailer.key;
        _controller = YoutubePlayerController(
          initialVideoId: trailerKey!,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
            disableDragSeek: false,
            loop: false,
            isLive: false, // Set to true if the video is a live stream
          ),
        );

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching trailer: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    // Ensure the screen orientation is reset when leaving the screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  void _enterFullScreen() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _exitFullScreen() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trailer'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : trailerKey != null
          ? YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          onReady: () {
            _controller.play();
            _enterFullScreen(); // Enter full-screen when the video starts
          },
          onEnded: (YoutubeMetaData metaData) {
            _exitFullScreen(); // Exit full-screen when the video ends
          },
        ),
        builder: (context, player) {
          return Column(
            children: [
              // YouTube Player
              Expanded(child: player),
              // Additional Widgets (if any) can be placed below
            ],
          );
        },
      )
          : const Center(child: Text("No trailer available")),
    );
  }
}
