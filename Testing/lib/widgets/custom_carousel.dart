import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:showbox/common/utils.dart';
import 'package:showbox/models/top_rated_tv_series.dart';

import '../screens/tv_detailed_screen.dart';
class CustomCarousel extends StatelessWidget {
  final TopRatedTvSeries data;
  const CustomCarousel({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: (size.height * 0.3 < 300 ) ? 300 : size.height * 0.33,
      child: CarouselSlider.builder(
        itemCount: data.results.length,
        itemBuilder: (BuildContext context, int index, int RealIndex) {
          var url = data.results[index].backdropPath.toString();

          return GestureDetector(
            onTap: () {
              // Navigate to the TvDetailScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TvDetailedScreen(seriesId: data.results[index].id),
                ),
              );
            },
            child: Column(
              children: [
                CachedNetworkImage(imageUrl: "https://image.tmdb.org/t/p/w500$url"),
                Text(data.results[index].name),
              ],
            ),
          );
        },
        options: CarouselOptions(
          height: (size.height * 0.3 < 300 ) ? 300 : size.height * 0.33,
          aspectRatio: 16/9,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}