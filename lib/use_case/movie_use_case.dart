import 'package:movies_app/model/movies_list.dart';
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
    required this.movieApiService,
    required this.movieDataBase,
    required this.sortingStrategyInterface,
  });

  final MovieApiService movieApiService;
  final MovieDatabase movieDataBase;
  final SortingStrategyInterface sortingStrategyInterface;

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
