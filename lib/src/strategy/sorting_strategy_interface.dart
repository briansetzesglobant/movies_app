import 'package:movies_app/src/domain/entity/movie_entity.dart';

abstract class SortingStrategyInterface {
  List<MovieEntity> execute(List<MovieEntity> moviesList);
}
