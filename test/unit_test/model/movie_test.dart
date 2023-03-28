import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/data/model/movie.dart';

void main() {
  late Movie movie;
  late Map<String, dynamic> json;

  setUp(() {
    movie = Movie(
      posterPath: 'posterPath',
      adult: true,
      overview: 'overview',
      releaseDate: 'releaseDate',
      genreIds: [],
      id: 1,
      originalTitle: 'originalTitle',
      originalLanguage: 'originalLanguage',
      title: 'title',
      backdropPath: 'backdropPath',
      popularity: 1.0,
      voteCount: 1,
      video: true,
      voteAverage: 1.0,
    );
    json = {
      'poster_path': 'posterPath',
      'adult': true,
      'overview': 'overview',
      'release_date': 'releaseDate',
      'genre_ids': [],
      'id': 1,
      'original_title': 'originalTitle',
      'original_language': 'originalLanguage',
      'title': 'title',
      'backdrop_path': 'backdropPath',
      'popularity': 1.0,
      'vote_count': 1,
      'video': true,
      'vote_average': 1.0
    };
  });

  group('Movie test', () {
    test(
      'fromJson() should transform the json to movie model',
      () async {
        final movieModel = Movie.fromJson(
          json,
        );
        expect(movieModel.title, movie.title);
      },
    );

    test(
      'toJson() should transform the movie model to json',
      () async {
        final jsonMovie = movie.toJson();
        expect(jsonMovie, json);
      },
    );
  });
}
