import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/data/model/movie.dart';
import 'package:movies_app/src/data/model/movies_list.dart';

void main() {
  late MoviesList moviesList;
  late Map<String, dynamic> json;

  setUp(() {
    moviesList = MoviesList(
      page: 1,
      results: [
        Movie(
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
        )
      ],
      totalResults: 1,
      totalPages: 1,
    );
    json = {
      'page': 1,
      'results': [
        {
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
        },
      ],
      'total_pages': 1,
      'total_results': 1
    };
  });

  group('MovieList test', () {
    test(
      'fromJson() should transform the json to movies list model',
      () async {
        final moviesListModel = MoviesList.fromJson(
          json,
        );
        expect(moviesListModel.results.first.title,
            moviesList.results.first.title);
      },
    );
  });
}
