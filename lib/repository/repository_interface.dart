import 'package:movies_app/data_state.dart';
import 'package:movies_app/model/movies_list.dart';

abstract class RepositoryInterface {
  Future<DataState<MoviesList>> getMoviesList();
}
