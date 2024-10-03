import 'dart:convert';

class TvRecommendationsModel {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  TvRecommendationsModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  TvRecommendationsModel copyWith({
    int? page,
    List<Result>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      TvRecommendationsModel(
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory TvRecommendationsModel.fromRawJson(String str) => TvRecommendationsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvRecommendationsModel.fromJson(Map<String, dynamic> json) => TvRecommendationsModel(
    page: json["page"] ?? 0,  // Default to 0 if null
    results: List<Result>.from(json["results"]?.map((x) => Result.fromJson(x)) ?? []), // Default to empty list if null
    totalPages: json["total_pages"] ?? 0,  // Default to 0 if null
    totalResults: json["total_results"] ?? 0,  // Default to 0 if null
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  String backdropPath;
  int id;
  String name;
  String originalName;
  String overview;
  String posterPath;
  MediaType mediaType;
  bool adult;
  OriginalLanguage originalLanguage;
  List<int> genreIds;
  double popularity;
  DateTime firstAirDate;
  double voteAverage;
  int voteCount;
  List<OriginCountry> originCountry;

  Result({
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
  });

  Result copyWith({
    String? backdropPath,
    int? id,
    String? name,
    String? originalName,
    String? overview,
    String? posterPath,
    MediaType? mediaType,
    bool? adult,
    OriginalLanguage? originalLanguage,
    List<int>? genreIds,
    double? popularity,
    DateTime? firstAirDate,
    double? voteAverage,
    int? voteCount,
    List<OriginCountry>? originCountry,
  }) =>
      Result(
        backdropPath: backdropPath ?? this.backdropPath,
        id: id ?? this.id,
        name: name ?? this.name,
        originalName: originalName ?? this.originalName,
        overview: overview ?? this.overview,
        posterPath: posterPath ?? this.posterPath,
        mediaType: mediaType ?? this.mediaType,
        adult: adult ?? this.adult,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        genreIds: genreIds ?? this.genreIds,
        popularity: popularity ?? this.popularity,
        firstAirDate: firstAirDate ?? this.firstAirDate,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
        originCountry: originCountry ?? this.originCountry,
      );

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    backdropPath: json["backdrop_path"] ?? '', // Default to empty string if null
    id: json["id"] ?? 0, // Default to 0 if null
    name: json["name"] ?? '', // Default to empty string if null
    originalName: json["original_name"] ?? '', // Default to empty string if null
    overview: json["overview"] ?? '', // Default to empty string if null
    posterPath: json["poster_path"] ?? '', // Default to empty string if null
    mediaType: mediaTypeValues.map[json["media_type"]] ?? MediaType.TV, // Default to TV if null
    adult: json["adult"] ?? false, // Default to false if null
    originalLanguage: originalLanguageValues.map[json["original_language"]] ?? OriginalLanguage.EN, // Default to EN if null
    genreIds: List<int>.from(json["genre_ids"]?.map((x) => x) ?? []), // Default to empty list if null
    popularity: (json["popularity"] ?? 0.0).toDouble(), // Default to 0.0 if null
    firstAirDate: DateTime.tryParse(json["first_air_date"] ?? DateTime.now().toIso8601String()) ?? DateTime.now(), // Default to now if parsing fails
    voteAverage: (json["vote_average"] ?? 0.0).toDouble(), // Default to 0.0 if null
    voteCount: json["vote_count"] ?? 0, // Default to 0 if null
    originCountry: List<OriginCountry>.from(json["origin_country"]?.map((x) => originCountryValues.map[x] ?? OriginCountry.US) ?? []), // Default to US if null
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "id": id,
    "name": name,
    "original_name": originalName,
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaTypeValues.reverse[mediaType]!,
    "adult": adult,
    "original_language": originalLanguageValues.reverse[originalLanguage]!,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "popularity": popularity,
    "first_air_date": "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "origin_country": List<dynamic>.from(originCountry.map((x) => originCountryValues.reverse[x])),
  };
}

enum MediaType {
  TV
}

final mediaTypeValues = EnumValues({
  "tv": MediaType.TV
});

enum OriginCountry {
  ES,
  GB,
  JP,
  US
}

final originCountryValues = EnumValues({
  "ES": OriginCountry.ES,
  "GB": OriginCountry.GB,
  "JP": OriginCountry.JP,
  "US": OriginCountry.US
});

enum OriginalLanguage {
  EN,
  ES,
  JA
}

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
  "ja": OriginalLanguage.JA
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
