import 'package:get/get.dart';
import 'package:movies_app/model/movies_list.dart';
import 'package:movies_app/repository/movie_repository.dart';
import 'package:movies_app/strategy/ascending_sort_strategy.dart';
import 'package:movies_app/strategy/descending_sort_strategy.dart';
import 'package:movies_app/strategy/sorting_strategy_interface.dart';
import 'package:movies_app/use_case/use_case_interface.dart';
import '../data_state.dart';
import '../movie_data_base.dart';

class MovieUseCase extends UseCaseInterface<DataState<MoviesList>> {
  MovieUseCase({
    required this.sortingWay,
  });

  final bool sortingWay;
  final MovieRepository movieRepository = Get.find<MovieRepository>();
  final MovieDatabase movieDataBase = Get.find<MovieDatabase>();
  late final SortingStrategyInterface sortingStrategyInterface = sortingWay
      ? Get.find<AscendingSortStrategy>()
      : Get.find<DescendingSortStrategy>();

  @override
  Future<DataState<MoviesList>> call() async {
    DataState<MoviesList> moviesList = await movieRepository.getMoviesList();
    if (moviesList.type == DataStateType.success) {
      return DataSuccess(
        moviesList.data!.copyWith(
          results:
              sortingStrategyInterface.execute(await movieDataBase.getMovies()),
        ),
      );
    } else {
      return moviesList;
    }
  }
}
