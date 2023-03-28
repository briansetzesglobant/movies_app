import 'package:movies_app/src/domain/entity/movies_list_entity.dart';
import 'movie.dart';

class MoviesList extends MoviesListEntity {
  MoviesList({
    required int page,
    required List<Movie> results,
    required int totalResults,
    required int totalPages,
  }) : super(
          page: page,
          results: results,
          totalResults: totalResults,
          totalPages: totalPages,
        );

  factory MoviesList.fromJson(Map<String, dynamic> json) {
    var jsonList = json['results'] as List;
    List<Movie> moviesList =
        jsonList.map((movie) => Movie.fromJson(movie)).toList();
    return MoviesList(
      page: json['page'],
      results: moviesList,
      totalResults: json['total_results'],
      totalPages: json['total_pages'],
    );
  }
}
