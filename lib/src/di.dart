import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:movies_app/src/presentation/bloc/images_bloc.dart';
import 'package:movies_app/src/presentation/bloc/movie_bloc.dart';
import 'package:movies_app/src/data/repository/movie_repository.dart';
import 'core/util/strings.dart';
import 'data/data_source/local/images_storage.dart';
import 'data/data_source/local/movie_data_base.dart';
import 'data/data_source/remote/movie_api_service.dart';
import 'domain/use_case/implementation/movie_use_case.dart';
import 'domain/use_case/implementation/popularity_movie_use_case.dart';
import 'strategy/ascending_sort_strategy.dart';
import 'strategy/descending_sort_strategy.dart';

class Di {
  void injectDependencies() {
    Get.lazyPut(
      () => ImagesStorage.instance,
    );
    Get.lazyPut(
      () => ImagesBloc(),
    );
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
