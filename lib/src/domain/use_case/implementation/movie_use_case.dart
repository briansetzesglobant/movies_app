import 'package:get/get.dart';
import 'package:movies_app/src/data/repository/movie_repository.dart';
import 'package:movies_app/src/core/use_case/use_case_interface.dart';
import '../../../core/resource/data_state.dart';
import '../../../data/model/movies_list.dart';
import '../../../strategy/ascending_sort_strategy.dart';
import '../../../strategy/descending_sort_strategy.dart';
import '../../../strategy/sorting_strategy_interface.dart';
import '../../entity/movies_list_entity.dart';

class MovieUseCase extends UseCaseInterface<DataState<MoviesListEntity>> {
  MovieUseCase({
    required this.sortingWay,
  });

  final bool sortingWay;
  final MovieRepository movieRepository = Get.find<MovieRepository>();
  late final SortingStrategyInterface sortingStrategyInterface = sortingWay
      ? Get.find<AscendingSortStrategy>()
      : Get.find<DescendingSortStrategy>();

  @override
  Future<DataState<MoviesListEntity>> call() async {
    DataState<MoviesListEntity> moviesList =
        await movieRepository.getMoviesList();
    if (moviesList.type == DataStateType.success) {
      return DataSuccess(
        moviesList.data!.copyWith(
          results: sortingStrategyInterface.execute(moviesList.data!.results),
        ),
      );
    } else {
      return moviesList;
    }
  }
}
