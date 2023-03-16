import 'package:movies_app/model/movies_list.dart';
import '../data_state.dart';
import '../model/movie.dart';
import '../util/numbers.dart';
import 'movie_use_case.dart';

class PopularityMovieUseCase extends MovieUseCase {
  PopularityMovieUseCase({
    required sortingWay,
  }) : super(
          sortingWay: sortingWay,
        );

  @override
  Future<DataState<MoviesList>> call() async {
    DataState<MoviesList> moviesList = await super.call();
    List<Movie> movies = [];
    for (var movie in moviesList.data!) {
      if (movie.popularity >= Numbers.popularityCondition) {
        movies.add(movie);
      }
    }
    return moviesList.type == DataStateType.success
        ? DataSuccess(
            moviesList.data!.copyWith(results: movies),
          )
        : moviesList;
  }
}
