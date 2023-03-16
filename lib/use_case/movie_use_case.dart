import 'package:get/get.dart';
import 'package:movies_app/model/movies_list.dart';
import 'package:movies_app/strategy/ascending_sort_strategy.dart';
import 'package:movies_app/strategy/descending_sort_strategy.dart';
import 'package:movies_app/strategy/sorting_strategy_interface.dart';
import 'package:movies_app/use_case/use_case_interface.dart';
import 'package:movies_app/util/numbers.dart';
import '../data_state.dart';
import '../model/movie.dart';
import '../movie_api_service.dart';
import '../movie_data_base.dart';
import '../util/strings.dart';

class MovieUseCase extends UseCaseInterface<DataState<MoviesList>> {
  MovieUseCase({
    required this.sortingWay,
  });

  final bool sortingWay;
  final MovieApiService movieApiService = Get.find<MovieApiService>();
  final MovieDatabase movieDataBase = Get.find<MovieDatabase>();
  late final SortingStrategyInterface sortingStrategyInterface = sortingWay
      ? Get.find<AscendingSortStrategy>()
      : Get.find<DescendingSortStrategy>();

  @override
  Future<DataState<MoviesList>> call() async {
    DataState<MoviesList> moviesList = await movieApiService.getMoviesList();
    switch (moviesList.type) {
      case DataStateType.success:
        try {
          if (moviesList.data!.results.isNotEmpty == true) {
            await movieDataBase.dropMovieCollection();
            for (var movie in moviesList.data!) {
              await movieDataBase.insertMovie(movie);
            }
          }
          return DataSuccess(
            moviesList.data!.copyWith(
              results: sortingStrategyInterface
                  .execute(await movieDataBase.getMovies()),
            ),
          );
        } catch (exception) {
          return DataFailed(
            '${Strings.error} ${exception.toString()}',
          );
        }
      case DataStateType.empty:
        return await _getDataOfDataBase();
      case DataStateType.error:
        return await _getDataOfDataBase();
    }
  }

  Future<DataState<MoviesList>> _getDataOfDataBase() async {
    try {
      List<Movie> results = await movieDataBase.getMovies();
      if (results.isNotEmpty) {
        DataSuccess<MoviesList> dataSuccess = DataSuccess(
          MoviesList(
            page: Numbers.moviePageDefaultValue,
            results: sortingStrategyInterface
                .execute(await movieDataBase.getMovies()),
            totalResults: Numbers.movieTotalResultsDefaultValue,
            totalPages: Numbers.movieTotalPagesDefaultValue,
          ),
        );
        return dataSuccess;
      } else {
        return const DataEmpty();
      }
    } catch (exception) {
      return DataFailed(
        '${Strings.error} ${exception.toString()}',
      );
    }
  }
}
