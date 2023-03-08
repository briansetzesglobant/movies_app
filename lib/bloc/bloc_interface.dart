import 'package:movies_app/model/movies_list.dart';
import '../data_state.dart';
import 'bloc.dart';

abstract class BlocInterface extends Bloc {
  Future<DataState<MoviesList>> getMoviesList();
}
