import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/movie.dart';
import 'util/strings.dart';

class MovieDatabase {
  MovieDatabase();

  FirebaseFirestore get instanceFirestore => FirebaseFirestore.instance;

  CollectionReference get movieCollection =>
      instanceFirestore.collection(Strings.movieCollectionName);

  Future<void> dropMovieCollection() async => await movieCollection.get().then(
        (value) {
          for (QueryDocumentSnapshot<Object?> doc in value.docs) {
            doc.reference.delete();
          }
        },
      );

  Future<void> insertMovie(Movie movie) async {
    await movieCollection.doc('${movie.id}').set(
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
    QuerySnapshot querySnapshot = await movieCollection.get();
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
