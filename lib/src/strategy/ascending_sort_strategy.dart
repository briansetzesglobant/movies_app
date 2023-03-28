import 'package:movies_app/src/domain/entity/movie_entity.dart';
import 'sorting_strategy_interface.dart';

class AscendingSortStrategy implements SortingStrategyInterface {
  @override
  List<MovieEntity> execute(List<MovieEntity> moviesList) {
    moviesList.sort((movieA, movieB) => movieA.title.compareTo(movieB.title));
    return moviesList;
  }
}
