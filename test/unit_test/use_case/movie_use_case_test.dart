import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/src/core/resource/data_state.dart';
import 'package:movies_app/src/data/repository/movie_repository.dart';
import 'package:movies_app/src/domain/entity/movie_entity.dart';
import 'package:movies_app/src/domain/entity/movies_list_entity.dart';
import 'package:movies_app/src/domain/use_case/implementation/movie_use_case.dart';
import 'package:movies_app/src/strategy/ascending_sort_strategy.dart';
import 'movie_use_case_test.mocks.dart';

@GenerateMocks([
  MovieRepository,
  AscendingSortStrategy,
])
void main() {
  late MovieUseCase movieUseCase;
  late MovieRepository movieRepository;
  late AscendingSortStrategy ascendingSortStrategy;
  late DataState<MoviesListEntity> dataStateSuccess;
  late DataState<MoviesListEntity> dataStateEmpty;
  late DataState<MoviesListEntity> dataStateFailed;
  late MovieEntity movieEntity1;
  late MovieEntity movieEntity2;
  late MoviesListEntity moviesListEntity;

  setUp(() {
    movieRepository = MockMovieRepository();
    Get.replace(movieRepository);
    ascendingSortStrategy = MockAscendingSortStrategy();
    Get.replace(ascendingSortStrategy);
    movieUseCase = MovieUseCase(
      sortingWay: true,
    );
    movieEntity1 = MovieEntity(
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
    movieEntity2 = MovieEntity(
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
    moviesListEntity = MoviesListEntity(
      page: 1,
      results: [movieEntity2, movieEntity1],
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

  group('MovieUseCase test', () {
    test(
      'call() should get the status success',
      () async {
        when(movieRepository.getMoviesList())
            .thenAnswer((_) async => dataStateSuccess);
        when(ascendingSortStrategy.execute([movieEntity2, movieEntity1]))
            .thenAnswer((_) => [movieEntity1, movieEntity2]);
        final response = await movieUseCase();
        verify(movieRepository.getMoviesList()).called(1);
        verify(ascendingSortStrategy.execute([movieEntity2, movieEntity1])).called(1);
        expect(
          response.data!.results.first,
          dataStateSuccess.data!.results.last,
        );
        expect(
          response.data!.results.last,
          dataStateSuccess.data!.results.first,
        );
        expect(
          response.error,
          null,
        );
        expect(
          response.data!.results.first.title,
          movieEntity1.title,
        );
        expect(
          response.data!.results.last.title,
          movieEntity2.title,
        );
        assert(response is DataSuccess);
      },
    );

    test(
      'call() should get the status empty',
      () async {
        when(movieRepository.getMoviesList())
            .thenAnswer((_) async => dataStateEmpty);
        final response = await movieUseCase();
        verify(movieRepository.getMoviesList()).called(1);
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
      'call() should get the status failed',
      () async {
        when(movieRepository.getMoviesList())
            .thenAnswer((_) async => dataStateFailed);
        final response = await movieUseCase();
        verify(movieRepository.getMoviesList()).called(1);
        expect(
          response.data,
          null,
        );
        expect(
          response.error,
          dataStateFailed.error,
        );
        assert(response is DataFailed);
      },
    );
  });
}
