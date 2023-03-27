import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/data_state.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/model/movies_list.dart';
import 'package:movies_app/repository/movie_repository.dart';
import 'package:movies_app/strategy/descending_sort_strategy.dart';
import 'package:movies_app/use_case/popularity_movie_use_case.dart';
import 'popularity_movie_use_case_test.mocks.dart';

@GenerateMocks([
  MovieRepository,
  DescendingSortStrategy,
])
void main() {
  late PopularityMovieUseCase popularityMovieUseCase;
  late MovieRepository movieRepository;
  late DescendingSortStrategy descendingSortStrategy;
  late DataState<MoviesList> dataStateSuccess;
  late DataState<MoviesList> dataStateEmpty;
  late DataState<MoviesList> dataStateFailed;
  late Movie movie1;
  late Movie movie2;
  late MoviesList moviesList;

  setUp(() {
    movieRepository = MockMovieRepository();
    Get.replace(movieRepository);
    descendingSortStrategy = MockDescendingSortStrategy();
    Get.replace(descendingSortStrategy);
    popularityMovieUseCase = PopularityMovieUseCase(
      sortingWay: false,
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
      popularity: 1500.0,
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
      popularity: 1500.0,
      voteCount: 1,
      video: true,
      voteAverage: 1.0,
    );
    moviesList = MoviesList(
      page: 1,
      results: [movie1, movie2],
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
        when(descendingSortStrategy.execute([movie1, movie2]))
            .thenAnswer((_) => [movie2, movie1]);
        final response = await popularityMovieUseCase();
        verify(movieRepository.getMoviesList()).called(1);
        verify(descendingSortStrategy.execute([movie1, movie2])).called(1);
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
          movie2.title,
        );
        expect(
          response.data!.results.last.title,
          movie1.title,
        );
        assert(response is DataSuccess);
      },
    );

    test(
      'call() should get the status empty',
      () async {
        when(movieRepository.getMoviesList())
            .thenAnswer((_) async => dataStateEmpty);
        final response = await popularityMovieUseCase();
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
        final response = await popularityMovieUseCase();
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
