import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/model/movies_list.dart';

void main() {
  late Movie movie1;
  late Movie movie2;
  late Movie movie3;
  late MoviesList moviesList;
  late Map<String, dynamic> json;

  setUp(() {
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
    movie3 = Movie(
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
    moviesList = MoviesList(
      page: 1,
      results: [movie1, movie2, movie3],
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
          'title': 'title1',
          'backdrop_path': 'backdropPath',
          'popularity': 1.0,
          'vote_count': 1,
          'video': true,
          'vote_average': 1.0
        },
        {
          'poster_path': 'posterPath',
          'adult': true,
          'overview': 'overview',
          'release_date': 'releaseDate',
          'genre_ids': [],
          'id': 1,
          'original_title': 'originalTitle',
          'original_language': 'originalLanguage',
          'title': 'title2',
          'backdrop_path': 'backdropPath',
          'popularity': 1.0,
          'vote_count': 1,
          'video': true,
          'vote_average': 1.0
        },
        {
          'poster_path': 'posterPath',
          'adult': true,
          'overview': 'overview',
          'release_date': 'releaseDate',
          'genre_ids': [],
          'id': 1,
          'original_title': 'originalTitle',
          'original_language': 'originalLanguage',
          'title': 'title3',
          'backdrop_path': 'backdropPath',
          'popularity': 1.0,
          'vote_count': 1,
          'video': true,
          'vote_average': 1.0
        }
      ],
      'total_pages': 1,
      'total_results': 1
    };
  });

  group('MovieUseCase test', () {
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

    test(
      'copyWith() should clone movies list model',
      () async {
        moviesList = moviesList.copyWith(page: 2);
        expect(moviesList.page, 2);
      },
    );

    test(
      'MoviesList should be iterable',
      () async {
        final moviesListIterable = MoviesList(
          page: 1,
          results: [],
          totalResults: 1,
          totalPages: 1,
        );
        int i = 0;
        for (var movie in moviesList) {
          moviesListIterable.results.add(movie);
          expect(
              moviesList.results[i].title, moviesListIterable.results[i].title);
          i++;
        }
      },
    );
  });
}
