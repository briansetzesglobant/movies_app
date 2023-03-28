import 'package:get/get.dart';
import 'package:movies_app/src/core/resource/data_state.dart';
import '../../core/util/numbers.dart';
import '../../core/util/strings.dart';
import '../../domain/entity/movie_entity.dart';
import '../../domain/entity/movies_list_entity.dart';
import '../data_source/local/movie_data_base.dart';
import '../data_source/remote/movie_api_service.dart';
import '../../domain/repository/repository_interface.dart';

class MovieRepository extends RepositoryInterface {
  final MovieApiService movieApiService = Get.find<MovieApiService>();
  final MovieDatabase movieDataBase = Get.find<MovieDatabase>();

  @override
  Future<DataState<MoviesListEntity>> getMoviesList() async {
    DataState<MoviesListEntity> moviesList =
        await movieApiService.getMoviesList();
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
              results: await movieDataBase.getMovies(),
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

  Future<DataState<MoviesListEntity>> _getDataOfDataBase() async {
    try {
      List<MovieEntity> results = await movieDataBase.getMovies();
      if (results.isNotEmpty) {
        DataSuccess<MoviesListEntity> dataSuccess = DataSuccess(
          MoviesListEntity(
            page: Numbers.moviePageDefaultValue,
            results: results,
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
