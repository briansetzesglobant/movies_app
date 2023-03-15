import '../model/movie.dart';

abstract class SortingStrategyInterface {
  List<Movie> execute(List<Movie> moviesList);
}
