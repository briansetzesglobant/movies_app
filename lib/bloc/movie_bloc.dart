import 'dart:async';
import 'package:movies_app/bloc/bloc_interface.dart';
import 'package:movies_app/model/movies_list.dart';
import 'package:movies_app/use_case/use_case_interface.dart';
import '../data_state.dart';

class MovieBloc extends BlocInterface {
  MovieBloc({
    required this.useCaseInterface,
  });

  final UseCaseInterface useCaseInterface;

  final StreamController<DataState<MoviesList>> _moviesListStreamController =
      StreamController();

  @override
  Stream<DataState<MoviesList>> get moviesListStream =>
      _moviesListStreamController.stream;

  @override
  Future<void> initialize() async {}

  @override
  void dispose() {
    _moviesListStreamController.close();
  }

  @override
  void getMoviesList() async {
    final moviesList = await useCaseInterface();
    _moviesListStreamController.sink.add(moviesList);
  }
}
