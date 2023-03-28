import 'package:movies_app/src/core/resource/data_state.dart';
import 'package:movies_app/src/domain/entity/movies_list_entity.dart';

abstract class RepositoryInterface {
  Future<DataState<MoviesListEntity>> getMoviesList();
}
