import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/src/core/resource/data_state.dart';
import 'package:movies_app/src/data/data_source/local/movie_data_base.dart';
import 'package:movies_app/src/data/data_source/remote/movie_api_service.dart';
import 'package:movies_app/src/data/repository/movie_repository.dart';
import 'package:movies_app/src/domain/entity/movie_entity.dart';
import 'package:movies_app/src/domain/entity/movies_list_entity.dart';
import 'movie_repository_test.mocks.dart';

@GenerateMocks([
  MovieApiService,
  MovieDatabase,
])
void main() {
  late MovieRepository movieRepository;
  late MovieApiService movieApiService;
  late MovieDatabase movieDatabase;
  late DataState<MoviesListEntity> dataStateSuccess;
  late DataState<MoviesListEntity> dataStateEmpty;
  late DataState<MoviesListEntity> dataStateFailed;
  late MovieEntity movieEntity;
  late MoviesListEntity moviesListEntity;

  setUp(() {
    movieApiService = MockMovieApiService();
    Get.replace(movieApiService);
    movieDatabase = MockMovieDatabase();
    Get.replace(movieDatabase);
    movieRepository = MovieRepository();
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
    moviesListEntity = MoviesListEntity(
      page: 1,
      results: [movieEntity],
      totalResults: 1,
      totalPages: 1,
    );
    dataStateSuccess = DataSuccess(
      moviesListEntity,
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
        when(movieDatabase.insertMovie(movieEntity))
            .thenAnswer((_) async => true);
        when(movieDatabase.getMovies()).thenAnswer((_) async => [movieEntity]);
        final response = await movieRepository.getMoviesList();
        verify(movieApiService.getMoviesList()).called(1);
        verify(movieDatabase.dropMovieCollection()).called(1);
        verify(movieDatabase.insertMovie(movieEntity)).called(1);
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
        when(movieDatabase.getMovies()).thenAnswer((_) async => [movieEntity]);
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
        when(movieDatabase.getMovies()).thenAnswer((_) async => [movieEntity]);
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
        when(movieDatabase.insertMovie(movieEntity))
            .thenAnswer((_) async => true);
        when(movieDatabase.getMovies()).thenThrow(exception);
        final response = await movieRepository.getMoviesList();
        verify(movieApiService.getMoviesList()).called(1);
        verify(movieDatabase.dropMovieCollection()).called(1);
        verify(movieDatabase.insertMovie(movieEntity)).called(1);
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
