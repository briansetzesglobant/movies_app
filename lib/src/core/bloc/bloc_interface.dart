import '../../domain/entity/movies_list_entity.dart';
import '../resource/data_state.dart';
import 'bloc.dart';

abstract class BlocInterface extends Bloc {
  Stream<DataState<MoviesListEntity>> get moviesListStream;

  void getMoviesList();
}
