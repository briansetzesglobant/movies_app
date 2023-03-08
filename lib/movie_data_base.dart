import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/movie.dart';
import 'util/strings.dart';

class MovieDatabase {
  MovieDatabase._privateConstructor();

  static final MovieDatabase instance = MovieDatabase._privateConstructor();

  static final FirebaseFirestore _instanceFirestore =
      FirebaseFirestore.instance;

  static final CollectionReference _movieCollection =
      _instanceFirestore.collection(Strings.movieCollectionName);

  Future<void> dropMovieCollection() async => await _movieCollection.get().then(
        (value) {
          for (QueryDocumentSnapshot<Object?> doc in value.docs) {
            doc.reference.delete();
          }
        },
      );

  Future<void> insertMovie(Movie movie) async {
    await _movieCollection.doc('${movie.id}').set(
          Movie(
            posterPath: movie.posterPath,
            adult: movie.adult,
            overview: movie.overview,
            releaseDate: movie.releaseDate,
            genreIds: movie.genreIds,
            id: movie.id,
            originalTitle: movie.originalTitle,
            originalLanguage: movie.originalLanguage,
            title: movie.title,
            backdropPath: movie.backdropPath,
            popularity: movie.popularity,
            voteCount: movie.voteCount,
            video: movie.video,
            voteAverage: movie.voteAverage,
          ).toJson(),
        );
  }

  Future<List<Movie>> getMovies() async {
    List<Movie> moviesList = [];
    QuerySnapshot querySnapshot = await _movieCollection.get();
    for (var doc in querySnapshot.docs) {
      try {
        moviesList.add(
          Movie.fromJson(
            doc.data() as Map<String, dynamic>,
          ),
        );
      } catch (e) {
        rethrow;
      }
    }
    return moviesList;
  }
}
