import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/src/domain/entity/movie_entity.dart';
import 'package:movies_app/src/domain/entity/movies_list_entity.dart';
import 'package:movies_app/src/domain/use_case/implementation/movie_use_case.dart';
import 'package:movies_app/src/presentation/bloc/movie_bloc.dart';
import 'package:movies_app/src/core/resource/data_state.dart';
import 'movie_bloc_test.mocks.dart';

@GenerateMocks([
  MovieUseCase,
])
void main() {
  late MovieBloc movieBloc;
  late MovieUseCase movieUseCase;
  late DataState<MoviesListEntity> dataStateSuccess;
  late DataState<MoviesListEntity> dataStateEmpty;
  late DataState<MoviesListEntity> dataStateFailed;
  late MoviesListEntity moviesListEntity;

  setUp(() {
    movieUseCase = MockMovieUseCase();
    Get.put(movieUseCase);
    movieBloc = MovieBloc(
      useCase: true,
      sortingWay: true,
    );
    moviesListEntity = MoviesListEntity(
      page: 1,
      results: [
        MovieEntity(
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
    dataStateSuccess = DataSuccess(
      moviesListEntity,
    );
    dataStateEmpty = const DataEmpty();
    dataStateFailed = const DataFailed(
      'error',
    );
  });

  group('MovieBloc test', () {
    test(
      'getMoviesList() should get the status success',
      () async {
        movieBloc.initialize();
        when(movieUseCase()).thenAnswer((_) async => dataStateSuccess);
        movieBloc.getMoviesList();
        verify(movieUseCase()).called(1);
      },
    );

    test(
      'getMoviesList() should get the status empty',
      () async {
        movieBloc.initialize();
        when(movieUseCase()).thenAnswer((_) async => dataStateEmpty);
        movieBloc.getMoviesList();
        verify(movieUseCase()).called(1);
      },
    );

    test(
      'getMoviesList() should get the status failed',
      () async {
        movieBloc.initialize();
        when(movieUseCase()).thenAnswer((_) async => dataStateFailed);
        movieBloc.getMoviesList();
        verify(movieUseCase()).called(1);
      },
    );

    test('dispose() should close all observers', () {
      movieBloc.initialize();
      movieBloc.dispose();
    });
  });
}
