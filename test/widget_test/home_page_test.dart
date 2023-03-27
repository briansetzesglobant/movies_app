import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/bloc/movie_bloc.dart';
import 'package:movies_app/data_state.dart';
import 'package:movies_app/home_page.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/model/movies_list.dart';
import 'package:movies_app/widget/movie_card.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'home_page_test.mocks.dart';

@GenerateMocks([
  MovieBloc,
])
void main() {
  late MovieBloc movieBloc;
  late DataState<MoviesList> dataStateSuccess;
  late DataState<MoviesList> dataStateEmpty;
  late DataState<MoviesList> dataStateFailed;
  late MoviesList moviesList;

  setUp(() {
    movieBloc = MockMovieBloc();
    Get.replace(movieBloc);
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

  group('HomePage test', () {
    testWidgets('HomePage() should display the success page',
        (WidgetTester tester) async {
      when(movieBloc.getMoviesList()).thenAnswer((_) async => dataStateSuccess);
      await tester.runAsync(() async {
        await mockNetworkImagesFor(
          () => tester.pumpWidget(
            MaterialApp(
              home: HomePage(
                title: 'title',
                useCase: true,
                sortingWay: true,
              ),
            ),
          ),
        );
      });
      expect(find.byType(MovieCard), findsOneWidget);
      expect(find.text('No movies to show'), findsNothing);
      expect(find.text('error'), findsNothing);
    });

    testWidgets('HomePage() should display the empty page',
        (WidgetTester tester) async {
      when(movieBloc.getMoviesList()).thenAnswer((_) async => dataStateEmpty);
      await tester.runAsync(() async {
        await mockNetworkImagesFor(
          () => tester.pumpWidget(
            MaterialApp(
              home: HomePage(
                title: 'title',
                useCase: true,
                sortingWay: true,
              ),
            ),
          ),
        );
      });
      expect(find.text('No movies to show'), findsOneWidget);
      expect(find.byType(MovieCard), findsNothing);
      expect(find.text('error'), findsNothing);
    });

    testWidgets('HomePage() should display the error page',
        (WidgetTester tester) async {
      when(movieBloc.getMoviesList()).thenAnswer((_) async => dataStateFailed);
      await tester.runAsync(() async {
        await mockNetworkImagesFor(
          () => tester.pumpWidget(
            MaterialApp(
              home: HomePage(
                title: 'title',
                useCase: true,
                sortingWay: true,
              ),
            ),
          ),
        );
      });
      expect(find.text('error'), findsOneWidget);
      expect(find.byType(MovieCard), findsNothing);
      expect(find.text('No movies to show'), findsNothing);
    });
  });
}
