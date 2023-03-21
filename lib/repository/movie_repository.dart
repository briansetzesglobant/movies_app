import 'package:get/get.dart';
import 'package:movies_app/data_state.dart';
import 'package:movies_app/model/movies_list.dart';
import '../model/movie.dart';
import '../movie_api_service.dart';
import '../movie_data_base.dart';
import '../util/numbers.dart';
import '../util/strings.dart';
import 'repository_interface.dart';

class MovieRepository extends RepositoryInterface {
  MovieApiService movieApiService = Get.find<MovieApiService>();
  final MovieDatabase movieDataBase = Get.find<MovieDatabase>();

  @override
  Future<DataState<MoviesList>> getMoviesList() async {
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

  Future<DataState<MoviesList>> _getDataOfDataBase() async {
    try {
      List<Movie> results = await movieDataBase.getMovies();
      if (results.isNotEmpty) {
        DataSuccess<MoviesList> dataSuccess = DataSuccess(
          MoviesList(
            page: Numbers.moviePageDefaultValue,
            results: await movieDataBase.getMovies(),
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
