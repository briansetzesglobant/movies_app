import 'dart:async';
import 'package:get/get.dart';
import 'package:movies_app/bloc/bloc_interface.dart';
import 'package:movies_app/model/movies_list.dart';
import 'package:movies_app/use_case/use_case_interface.dart';
import '../data_state.dart';
import '../use_case/movie_use_case.dart';
import '../use_case/popularity_movie_use_case.dart';
import '../util/strings.dart';

class MovieBloc extends BlocInterface {
  MovieBloc({
    required this.useCase,
    required this.sortingWay,
  });

  final bool useCase;
  final bool sortingWay;
  late final UseCaseInterface useCaseInterface = useCase
      ? Get.find<MovieUseCase>(
          tag: sortingWay
              ? Strings.ascendingSortStrategy
              : Strings.descendingSortStrategy,
        )
      : Get.find<PopularityMovieUseCase>(
          tag: sortingWay
              ? Strings.ascendingSortStrategy
              : Strings.descendingSortStrategy,
        );

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
