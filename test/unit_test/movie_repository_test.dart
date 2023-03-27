import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/data_state.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/model/movies_list.dart';
import 'package:movies_app/movie_api_service.dart';
import 'package:movies_app/movie_data_base.dart';
import 'package:movies_app/repository/movie_repository.dart';
import 'movie_repository_test.mocks.dart';

@GenerateMocks([
  MovieApiService,
  MovieDatabase,
])
void main() {
  late MovieRepository movieRepository;
  late MovieApiService movieApiService;
  late MovieDatabase movieDatabase;
  late DataState<MoviesList> dataStateSuccess;
  late DataState<MoviesList> dataStateEmpty;
  late DataState<MoviesList> dataStateFailed;
  late Movie movie;
  late MoviesList moviesList;

  setUp(() {
    movieApiService = MockMovieApiService();
    Get.replace(movieApiService);
    movieDatabase = MockMovieDatabase();
    Get.replace(movieDatabase);
    movieRepository = MovieRepository();
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
    moviesList = MoviesList(
      page: 1,
      results: [movie],
      totalResults: 1,
      totalPages: 1,
    );
    dataStateSuccess = DataSuccess(
      moviesList,
    );
    dataStateEmpty = const DataEmpty();
    dataStateFailed = const DataFailed(
      'error',
    );
  });

  group('MovieRepository test', () {
    test(
      'getMoviesList() should get the status success when service state is success and database data is not empty',
      () async {
        when(movieApiService.getMoviesList())
            .thenAnswer((_) async => dataStateSuccess);
        when(movieDatabase.dropMovieCollection()).thenAnswer((_) async => true);
        when(movieDatabase.insertMovie(movie)).thenAnswer((_) async => true);
        when(movieDatabase.getMovies()).thenAnswer((_) async => [movie]);
        final response = await movieRepository.getMoviesList();
        verify(movieApiService.getMoviesList()).called(1);
        verify(movieDatabase.dropMovieCollection()).called(1);
        verify(movieDatabase.insertMovie(movie)).called(1);
        verify(movieDatabase.getMovies()).called(1);
        expect(
          response.data,
          dataStateSuccess.data,
        );
        expect(
          response.error,
          null,
        );
        assert(response is DataSuccess);
      },
    );

    test(
      'getMoviesList() should get the status success when service state is empty and database data is not empty',
      () async {
        when(movieApiService.getMoviesList())
            .thenAnswer((_) async => dataStateEmpty);
        when(movieDatabase.getMovies()).thenAnswer((_) async => [movie]);
        final response = await movieRepository.getMoviesList();
        verify(movieApiService.getMoviesList()).called(1);
        verify(movieDatabase.getMovies()).called(1);
        expect(
          response.data,
          dataStateSuccess.data,
        );
        expect(
          response.error,
          null,
        );
        assert(response is DataSuccess);
      },
    );

    test(
      'getMoviesList() should get the status success when service state is failed and database data is not empty',
      () async {
        when(movieApiService.getMoviesList())
            .thenAnswer((_) async => dataStateFailed);
        when(movieDatabase.getMovies()).thenAnswer((_) async => [movie]);
        final response = await movieRepository.getMoviesList();
        verify(movieApiService.getMoviesList()).called(1);
        verify(movieDatabase.getMovies()).called(1);
        expect(
          response.data,
          dataStateSuccess.data,
        );
        expect(
          response.error,
          null,
        );
        assert(response is DataSuccess);
      },
    );

    test(
      'getMoviesList() should get the status empty when service state is empty and database data is empty',
      () async {
        when(movieApiService.getMoviesList())
            .thenAnswer((_) async => dataStateEmpty);
        when(movieDatabase.getMovies()).thenAnswer((_) async => []);
        final response = await movieRepository.getMoviesList();
        verify(movieApiService.getMoviesList()).called(1);
        verify(movieDatabase.getMovies()).called(1);
        expect(
          response.data,
          null,
        );
        expect(
          response.error,
          null,
        );
        assert(response is DataEmpty);
      },
    );

    test(
      'getMoviesList() should get the status empty when service state is failed and database data is empty',
      () async {
        when(movieApiService.getMoviesList())
            .thenAnswer((_) async => dataStateFailed);
        when(movieDatabase.getMovies()).thenAnswer((_) async => []);
        final response = await movieRepository.getMoviesList();
        verify(movieApiService.getMoviesList()).called(1);
        verify(movieDatabase.getMovies()).called(1);
        expect(
          response.data,
          null,
        );
        expect(
          response.error,
          null,
        );
        assert(response is DataEmpty);
      },
    );

    test(
      'getMoviesList() should get the status failed when service state is success and database fail',
      () async {
        Exception exception = Exception();
        when(movieApiService.getMoviesList())
            .thenAnswer((_) async => dataStateSuccess);
        when(movieDatabase.dropMovieCollection()).thenAnswer((_) async => true);
        when(movieDatabase.insertMovie(movie)).thenAnswer((_) async => true);
        when(movieDatabase.getMovies()).thenThrow(exception);
        final response = await movieRepository.getMoviesList();
        verify(movieApiService.getMoviesList()).called(1);
        verify(movieDatabase.dropMovieCollection()).called(1);
        verify(movieDatabase.insertMovie(movie)).called(1);
        verify(movieDatabase.getMovies()).called(1);
        expect(
          response.data,
          null,
        );
        expect(
          response.error,
          'An error has occurred while loading movies: ${exception.toString()}',
        );
        assert(response is DataFailed);
      },
    );

    test(
      'getMoviesList() should get the status failed when service state is empty and database fail',
      () async {
        Exception exception = Exception();
        when(movieApiService.getMoviesList())
            .thenAnswer((_) async => dataStateEmpty);
        when(movieDatabase.getMovies()).thenThrow(exception);
        final response = await movieRepository.getMoviesList();
        verify(movieApiService.getMoviesList()).called(1);
        verify(movieDatabase.getMovies()).called(1);
        expect(
          response.data,
          null,
        );
        expect(
          response.error,
          'An error has occurred while loading movies: ${exception.toString()}',
        );
        assert(response is DataFailed);
      },
    );

    test(
      'getMoviesList() should get the status failed when service state is failed and database fail',
      () async {
        Exception exception = Exception();
        when(movieApiService.getMoviesList())
            .thenAnswer((_) async => dataStateFailed);
        when(movieDatabase.getMovies()).thenThrow(exception);
        final response = await movieRepository.getMoviesList();
        verify(movieApiService.getMoviesList()).called(1);
        verify(movieDatabase.getMovies()).called(1);
        expect(
          response.data,
          null,
        );
        expect(
          response.error,
          'An error has occurred while loading movies: ${exception.toString()}',
        );
        assert(response is DataFailed);
      },
    );
  });
}
