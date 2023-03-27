import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/bloc/movie_bloc.dart';
import 'package:movies_app/data_state.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/model/movies_list.dart';
import 'package:movies_app/use_case/movie_use_case.dart';
import 'movie_bloc_test.mocks.dart';

@GenerateMocks([
  MovieUseCase,
])
void main() {
  late MovieBloc movieBloc;
  late MovieUseCase movieUseCase;
  late DataState<MoviesList> dataStateSuccess;
  late DataState<MoviesList> dataStateEmpty;
  late DataState<MoviesList> dataStateFailed;
  late MoviesList moviesList;

  setUp(() {
    movieUseCase = MockMovieUseCase();
    Get.put(movieUseCase);
    movieBloc = MovieBloc(
      useCase: true,
      sortingWay: true,
    );
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
    dataStateSuccess = DataSuccess(
      moviesList,
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
        when(movieUseCase()).thenAnswer((_) async => dataStateSuccess);
        movieBloc.getMoviesList();
        verify(movieUseCase()).called(1);
      },
    );

    test(
      'getMoviesList() should get the status empty',
      () async {
        when(movieUseCase()).thenAnswer((_) async => dataStateEmpty);
        movieBloc.getMoviesList();
        verify(movieUseCase()).called(1);
      },
    );

    test(
      'getMoviesList() should get the status failed',
      () async {
        when(movieUseCase()).thenAnswer((_) async => dataStateFailed);
        movieBloc.getMoviesList();
        verify(movieUseCase()).called(1);
      },
    );

    test('dispose() should close all observers', () => movieBloc.dispose());
  });
}
