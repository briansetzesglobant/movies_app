import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/data_state.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/model/movies_list.dart';
import 'package:movies_app/repository/movie_repository.dart';
import 'package:movies_app/strategy/ascending_sort_strategy.dart';
import 'package:movies_app/use_case/movie_use_case.dart';
import 'movie_use_case_test.mocks.dart';

@GenerateMocks([
  MovieRepository,
  AscendingSortStrategy,
])
void main() {
  late MovieUseCase movieUseCase;
  late MovieRepository movieRepository;
  late AscendingSortStrategy ascendingSortStrategy;
  late DataState<MoviesList> dataStateSuccess;
  late DataState<MoviesList> dataStateEmpty;
  late DataState<MoviesList> dataStateFailed;
  late Movie movie1;
  late Movie movie2;
  late MoviesList moviesList;

  setUp(() {
    movieRepository = MockMovieRepository();
    Get.replace(movieRepository);
    ascendingSortStrategy = MockAscendingSortStrategy();
    Get.replace(ascendingSortStrategy);
    movieUseCase = MovieUseCase(
      sortingWay: true,
    );
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
    moviesList = MoviesList(
      page: 1,
      results: [movie2, movie1],
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

  group('MovieUseCase test', () {
    test(
      'call() should get the status success',
      () async {
        when(movieRepository.getMoviesList())
            .thenAnswer((_) async => dataStateSuccess);
        when(ascendingSortStrategy.execute([movie2, movie1]))
            .thenAnswer((_) => [movie1, movie2]);
        final response = await movieUseCase();
        verify(movieRepository.getMoviesList()).called(1);
        verify(ascendingSortStrategy.execute([movie2, movie1])).called(1);
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
          movie1.title,
        );
        expect(
          response.data!.results.last.title,
          movie2.title,
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
