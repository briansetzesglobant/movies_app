import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/domain/entity/movie_entity.dart';
import 'package:movies_app/src/domain/entity/movies_list_entity.dart';

void main() {
  late MovieEntity movie1Entity;
  late MovieEntity movieEntity2;
  late MovieEntity movieEntity3;
  late MoviesListEntity moviesListEntity;

  setUp(() {
    movie1Entity = MovieEntity(
      posterPath: 'posterPath',
      adult: true,
      overview: 'overview',
      releaseDate: 'releaseDate',
      genreIds: [],
      id: 1,
      originalTitle: 'originalTitle',
      originalLanguage: 'originalLanguage',
      title: 'title1',
      backdropPath: 'backdropPath',
      popularity: 1.0,
      voteCount: 1,
      video: true,
      voteAverage: 1.0,
    );
    movieEntity2 = MovieEntity(
      posterPath: 'posterPath',
      adult: true,
      overview: 'overview',
      releaseDate: 'releaseDate',
      genreIds: [],
      id: 1,
      originalTitle: 'originalTitle',
      originalLanguage: 'originalLanguage',
      title: 'title2',
      backdropPath: 'backdropPath',
      popularity: 1.0,
      voteCount: 1,
      video: true,
      voteAverage: 1.0,
    );
    movieEntity3 = MovieEntity(
      posterPath: 'posterPath',
      adult: true,
      overview: 'overview',
      releaseDate: 'releaseDate',
      genreIds: [],
      id: 1,
      originalTitle: 'originalTitle',
      originalLanguage: 'originalLanguage',
      title: 'title3',
      backdropPath: 'backdropPath',
      popularity: 1.0,
      voteCount: 1,
      video: true,
      voteAverage: 1.0,
    );
    moviesListEntity = MoviesListEntity(
      page: 1,
      results: [movie1Entity, movieEntity2, movieEntity3],
      totalResults: 1,
      totalPages: 1,
    );
  });

  group('MoviesListEntity test', () {
    test(
      'copyWith() should clone movies list model',
      () async {
        moviesListEntity = moviesListEntity.copyWith(
          page: 2,
        );
        expect(moviesListEntity.page, 2);
      },
    );

    test(
      'MoviesListEntity should be iterable',
      () async {
        final moviesListEntityIterable = MoviesListEntity(
          page: 1,
          results: [],
          totalResults: 1,
          totalPages: 1,
        );
        int i = 0;
        for (var movieEntity in moviesListEntity) {
          moviesListEntityIterable.results.add(movieEntity);
          expect(moviesListEntity.results[i].title,
              moviesListEntityIterable.results[i].title);
          i++;
        }
      },
    );
  });
}
