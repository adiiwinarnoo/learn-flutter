class ResponseDiscoverMovie {
  int page;
  int totalPages;
  List<ResultsItemDiscover> results;
  int totalResults;

   ResponseDiscoverMovie({
    required this.page,
    required this.totalPages,
    required this.results,
    required this.totalResults,
  });

  factory ResponseDiscoverMovie.fromJson(Map<String, dynamic> json) {
    return ResponseDiscoverMovie(
      page: json['page'] as int,
      totalPages: json['total_pages'] as int,
      results: (json['results'] as List)
          .map((e) => ResultsItemDiscover.fromJson(e))
          .toList(),
      totalResults: json['total_results'] as int,
    );
  }
}

class ResultsItemDiscover {
  String overview;
  String originalLanguage;
  String originalTitle;
  bool video;
  String title;
  List<int> genreIds;
  String posterPath;
  String backdropPath;
  String releaseDate;
  double popularity;
  num voteAverage;
  int id;
  bool adult;
  int voteCount;

  ResultsItemDiscover({
    required this.overview,
    required this.originalLanguage,
    required this.originalTitle,
    required this.video,
    required this.title,
    required this.genreIds,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.popularity,
    required this.voteAverage,
    required this.id,
    required this.adult,
    required this.voteCount,
  });

  factory ResultsItemDiscover.fromJson(Map<String, dynamic> json) {
    return ResultsItemDiscover(
      overview: json['overview'] as String,
      originalLanguage: json['original_language'] as String,
      originalTitle: json['original_title'] as String,
      video: json['video'] as bool,
      title: json['title'] as String,
      genreIds: (json['genre_ids'] as List).map((e) => e as int).toList(),
      posterPath: json['poster_path'] as String,
      backdropPath: json['backdrop_path'] as String,
      releaseDate: json['release_date'] as String,
      popularity: json['popularity'] as double,
      voteAverage: json['vote_average'] ,
      id: json['id'] as int,
      adult: json['adult'] as bool,
      voteCount: json['vote_count'] as int,
    );
  }
}
