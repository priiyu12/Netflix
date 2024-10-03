import 'package:flutter/material.dart';
import '../models/tv_series_detailed_model.dart'; // Assuming you have a model for detailed view
import '../services/api_services.dart'; // Assuming you have a service for API calls

class TvDetailedScreen extends StatefulWidget {
  final int seriesId;

  const TvDetailedScreen({Key? key, required this.seriesId}) : super(key: key);

  @override
  _TvDetailedScreenState createState() => _TvDetailedScreenState();
}

class _TvDetailedScreenState extends State<TvDetailedScreen> {
  late Future<TvSeriesDetailedModel> tvDetail; // Model for the detailed view
  ApiServices apiServices = ApiServices(); // Service for fetching data

  @override
  void initState() {
    super.initState();
    // Fetch details using the series ID
    tvDetail = apiServices.getTvSeriesDetail(widget.seriesId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TV Series Details"),
      ),
      body: FutureBuilder<TvSeriesDetailedModel>(
        future: tvDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            var series = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display series details here
                  Text(series.name),
                  Text(series.overview),
                  // Add more details as needed
                ],
              ),
            );
          } else {
            return Center(child: Text("No details available"));
          }
        },
      ),
    );
  }
}
