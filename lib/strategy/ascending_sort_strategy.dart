import 'package:movies_app/model/movie.dart';
import 'package:movies_app/strategy/sorting_strategy_interface.dart';

class AscendingSortStrategy implements SortingStrategyInterface {
  @override
  List<Movie> execute(List<Movie> moviesList) {
    moviesList.sort((movieA, movieB) => movieA.title.compareTo(movieB.title));
    return moviesList;
  }
}
