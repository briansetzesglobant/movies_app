import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/strategy/descending_sort_strategy.dart';

void main() {
  late DescendingSortStrategy descendingSortStrategy;
  late Movie movie1;
  late Movie movie2;

  setUp(() {
    descendingSortStrategy = DescendingSortStrategy();
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

  group('DescendingSortStrategy test', () {
    test(
      'execute() should get an descending sorted list',
      () async {
        final movies = descendingSortStrategy.execute([movie1, movie2]);
        expect(
          movies.first,
          movie2,
        );
        expect(
          movies.last,
          movie1,
        );
        expect(
          movies.first.title,
          movie2.title,
        );
        expect(
          movies.last.title,
          movie1.title,
        );
      },
    );
  });
}
