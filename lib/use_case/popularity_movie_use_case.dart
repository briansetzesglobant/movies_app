import 'package:movies_app/model/movies_list.dart';
import '../data_state.dart';
import '../util/numbers.dart';
import 'movie_use_case.dart';

class PopularityMovieUseCase extends MovieUseCase {
  PopularityMovieUseCase({
    required movieApiService,
    required movieDataBase,
  }) : super(
          movieApiService: movieApiService,
          movieDataBase: movieDataBase,
        );

  @override
  Future<DataState<MoviesList>> call() async {
    DataState<MoviesList> moviesList = await super.call();
    return moviesList.type == DataStateType.success
        ? DataSuccess(
            MoviesList(
              page: moviesList.data!.page,
              results: moviesList.data!.results
                  .where((element) =>
                      element.popularity >= Numbers.popularityCondition)
                  .toList(),
              totalResults: moviesList.data!.totalResults,
              totalPages: moviesList.data!.totalPages,
            ),
          )
        : moviesList;
  }
}
