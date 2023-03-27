import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/movie_data_base.dart';

void main() {
  late MovieDatabase movieDatabase;
  late Movie movie;

  setUp(() {
    movieDatabase = MovieDatabase.instance;
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
  });

  test(
    'MovieDataBase test',
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      Firebase.initializeApp().then((value) async {
        movieDatabase.insertMovie(movie);
        final moviesNotEmpty = await movieDatabase.getMovies();
        expect(moviesNotEmpty.length, 1);
        movieDatabase.dropMovieCollection();
        final moviesEmpty = await movieDatabase.getMovies();
        expect(moviesEmpty.length, 0);
      });
    },
  );
}
