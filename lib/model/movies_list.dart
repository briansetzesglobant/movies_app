import 'movie.dart';

class MoviesList {
  MoviesList({
    required this.page,
    required this.results,
    required this.totalResults,
    required this.totalPages,
  });

  factory MoviesList.fromJson(Map<String, dynamic> json) {
    var jsonList = json['results'] as List;
    List<Movie> moviesList =
        jsonList.map((movie) => Movie.fromJson(movie)).toList();
    return MoviesList(
      page: json['page'],
      totalResults: json['total_results'],
      totalPages: json['total_pages'],
      results: moviesList,
    );
  }

  MoviesList copyWith({
    int? page,
    int? totalResults,
    int? totalPages,
    List<Movie>? results,
  }) {
    return MoviesList(
      page: page ?? this.page,
      results: results ?? this.results,
      totalResults: totalResults ?? this.totalResults,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  final int page;
  final int totalResults;
  final int totalPages;
  final List<Movie> results;
}
