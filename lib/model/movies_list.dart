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

  final int page;
  final int totalResults;
  final int totalPages;
  final List<Movie> results;
}
