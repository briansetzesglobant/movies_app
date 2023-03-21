import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:movies_app/bloc/movie_bloc.dart';
import 'package:movies_app/movie_api_service.dart';
import 'package:movies_app/repository/movie_repository.dart';
import 'package:movies_app/strategy/ascending_sort_strategy.dart';
import 'package:movies_app/use_case/popularity_movie_use_case.dart';
import 'movie_data_base.dart';
import 'strategy/descending_sort_strategy.dart';
import 'use_case/movie_use_case.dart';
import 'util/strings.dart';

class Di {
  void injectDependencies() {
    Get.lazyPut(
      () => Client(),
    );
    Get.lazyPut(
      () => MovieApiService(),
    );
    Get.lazyPut(
      () => MovieRepository(),
    );
    Get.lazyPut(
      () => MovieDatabase.instance,
    );
    Get.lazyPut(
      () => AscendingSortStrategy(),
    );
    Get.lazyPut(
      () => DescendingSortStrategy(),
    );
    Get.lazyPut(
      () => MovieUseCase(
        sortingWay: true,
      ),
      tag: Strings.ascendingSortStrategy,
    );
    Get.lazyPut(
      () => MovieUseCase(
        sortingWay: false,
      ),
      tag: Strings.descendingSortStrategy,
    );
    Get.lazyPut(
      () => PopularityMovieUseCase(
        sortingWay: true,
      ),
      tag: Strings.ascendingSortStrategy,
    );
    Get.lazyPut(
      () => PopularityMovieUseCase(
        sortingWay: false,
      ),
      tag: Strings.descendingSortStrategy,
    );
    Get.lazyPut(
      () => MovieBloc(
        useCase: true,
        sortingWay: true,
      ),
      tag: Strings.movieUseCaseAscendingSortStrategy,
    );
    Get.lazyPut(
      () => MovieBloc(
        useCase: true,
        sortingWay: false,
      ),
      tag: Strings.movieUseCaseDescendingSortStrategy,
    );
    Get.lazyPut(
      () => MovieBloc(
        useCase: false,
        sortingWay: true,
      ),
      tag: Strings.popularityMovieUseCaseAscendingSortStrategy,
    );
    Get.lazyPut(
      () => MovieBloc(
        useCase: false,
        sortingWay: false,
      ),
      tag: Strings.popularityMovieUseCaseDescendingSortStrategy,
    );
  }
}
