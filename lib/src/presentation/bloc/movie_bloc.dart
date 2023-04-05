import 'dart:async';
import 'package:get/get.dart';
import 'package:movies_app/src/core/bloc/bloc_interface.dart';
import 'package:movies_app/src/core/use_case/use_case_interface.dart';
import '../../core/resource/data_state.dart';
import '../../core/util/strings.dart';
import '../../domain/entity/movies_list_entity.dart';
import '../../domain/use_case/implementation/movie_use_case.dart';
import '../../domain/use_case/implementation/popularity_movie_use_case.dart';

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

  late StreamController<DataState<MoviesListEntity>>
      _moviesListStreamController;

  @override
  Stream<DataState<MoviesListEntity>> get moviesListStream =>
      _moviesListStreamController.stream;

  @override
  Future<void> initialize() async {
    _moviesListStreamController = StreamController();
  }

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
