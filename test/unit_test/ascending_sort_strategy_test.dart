import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/strategy/ascending_sort_strategy.dart';

void main() {
  late AscendingSortStrategy ascendingSortStrategy;
  late Movie movie1;
  late Movie movie2;

  setUp(() {
    ascendingSortStrategy = AscendingSortStrategy();
    movie1 = Movie(
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
    movie2 = Movie(
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

  group('AscendingSortStrategy test', () {
    test(
      'execute() should get an ascending sorted list',
      () async {
        final movies = ascendingSortStrategy.execute([movie2, movie1]);
        expect(
          movies.first,
          movie1,
        );
        expect(
          movies.last,
          movie2,
        );
        expect(
          movies.first.title,
          movie1.title,
        );
        expect(
          movies.last.title,
          movie2.title,
        );
      },
    );
  });
}
