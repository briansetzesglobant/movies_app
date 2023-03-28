import 'package:movies_app/src/domain/entity/movie_entity.dart';
import '../../../core/resource/data_state.dart';
import '../../../core/util/numbers.dart';
import '../../entity/movies_list_entity.dart';
import 'movie_use_case.dart';

class PopularityMovieUseCase extends MovieUseCase {
  PopularityMovieUseCase({
    required sortingWay,
  }) : super(
          sortingWay: sortingWay,
        );

  @override
  Future<DataState<MoviesListEntity>> call() async {
    DataState<MoviesListEntity> moviesList = await super.call();
    List<MovieEntity> movies = [];
    if (moviesList.type == DataStateType.success) {
      for (var movie in moviesList.data!) {
        if (movie.popularity >= Numbers.popularityCondition) {
          movies.add(movie);
        }
      }
      return DataSuccess(
        moviesList.data!.copyWith(
          results: movies,
        ),
      );
    } else {
      return moviesList;
    }
  }
}
