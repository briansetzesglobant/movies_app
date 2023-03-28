import 'movie_entity.dart';

class MoviesListEntity extends Iterable<MovieEntity> {
  MoviesListEntity({
    required this.page,
    required this.results,
    required this.totalResults,
    required this.totalPages,
  });

  final int page;
  final int totalResults;
  final int totalPages;
  final List<MovieEntity> results;

  MoviesListEntity copyWith({
    int? page,
    List<MovieEntity>? results,
    int? totalResults,
    int? totalPages,
  }) {
    return MoviesListEntity(
      page: page ?? this.page,
      results: results ?? this.results,
      totalResults: totalResults ?? this.totalResults,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  Iterator<MovieEntity> get iterator => _MoviesListIterator(
        results: results,
      );
}

class _MoviesListIterator extends Iterator<MovieEntity> {
  _MoviesListIterator({
    required this.results,
  });

  final List<MovieEntity> results;
  int index = 0;

  @override
  MovieEntity get current => results[index++];

  @override
  bool moveNext() => index < results.length ? true : false;
}
