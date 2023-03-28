import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/data/data_source/local/movie_data_base.dart';
import 'package:movies_app/src/domain/entity/movie_entity.dart';

void main() {
  late MovieDatabase movieDatabase;
  late MovieEntity movieEntity;

  setUp(() {
    movieDatabase = MovieDatabase.instance;
    movieEntity = MovieEntity(
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
  });

  test(
    'MovieDataBase test',
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      Firebase.initializeApp().then((value) async {
        movieDatabase.insertMovie(movieEntity);
        final moviesNotEmpty = await movieDatabase.getMovies();
        expect(moviesNotEmpty.length, 1);
        movieDatabase.dropMovieCollection();
        final moviesEmpty = await movieDatabase.getMovies();
        expect(moviesEmpty.length, 0);
      });
    },
  );
}
