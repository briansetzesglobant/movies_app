import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/domain/entity/movie_entity.dart';
import 'package:movies_app/src/strategy/descending_sort_strategy.dart';

void main() {
  late DescendingSortStrategy descendingSortStrategy;
  late MovieEntity movieEntity1;
  late MovieEntity movieEntity2;

  setUp(() {
    descendingSortStrategy = DescendingSortStrategy();
    movieEntity1 = MovieEntity(
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
  });

  group('DescendingSortStrategy test', () {
    test(
      'execute() should get an descending sorted list',
      () async {
        final movies =
            descendingSortStrategy.execute([movieEntity1, movieEntity2]);
        expect(
          movies.first,
          movieEntity2,
        );
        expect(
          movies.last,
          movieEntity1,
        );
        expect(
          movies.first.title,
          movieEntity2.title,
        );
        expect(
          movies.last.title,
          movieEntity1.title,
        );
      },
    );
  });
}
