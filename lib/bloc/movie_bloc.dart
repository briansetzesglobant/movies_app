import 'package:movies_app/bloc/bloc_interface.dart';
import 'package:movies_app/model/movies_list.dart';
import 'package:movies_app/use_case/use_case_interface.dart';

import '../data_state.dart';

class MovieBloc extends BlocInterface {
  MovieBloc({
    required this.useCaseInterface,
  });

  final UseCaseInterface useCaseInterface;

  @override
  Future<void> initialize() async {}

  @override
  void dispose() {}

  @override
  Future<DataState<MoviesList>> getMoviesList() async {
    return await useCaseInterface();
  }
}
