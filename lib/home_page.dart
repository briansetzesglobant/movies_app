import 'package:flutter/material.dart';
import 'package:movies_app/util/assets.dart';
import 'package:movies_app/widget/movie_card.dart';
import 'package:movies_app/util/numbers.dart';
import 'data_state.dart';
import 'model/movies_list.dart';
import 'use_case/movie_use_case.dart';
import 'util/api_service.dart';
import 'util/strings.dart';
import 'widget/movie_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.movieUseCase,
  }) : super(
          key: key,
        );

  final MovieUseCase movieUseCase;

  Widget _getPage(DataState<MoviesList> moviesList) {
    switch (moviesList.type) {
      case DataStateType.success:
        return GridView.builder(
          itemCount: moviesList.data!.results.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Numbers.homePageCrossAxisCount,
          ),
          itemBuilder: (
            BuildContext context,
            int index,
          ) {
            return GridTile(
              child: MovieCard(
                title: moviesList.data!.results[index].title,
                image:
                    '${ApiService.imageNetwork}${moviesList.data!.results[index].posterPath}',
              ),
            );
          },
        );
      case DataStateType.empty:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.moviesEmptyPageImage,
              width: Numbers.moviePageImageSize,
              height: Numbers.moviePageImageSize,
            ),
            const MovieText(
              text: Strings.emptyGridMessage,
            ),
          ],
        );
      case DataStateType.error:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.moviesErrorPageImage,
              width: Numbers.moviePageImageSize,
              height: Numbers.moviePageImageSize,
            ),
            MovieText(
              text: moviesList.error!,
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.homePageTitle,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: movieUseCase(),
          builder: (
            context,
            AsyncSnapshot<DataState<MoviesList>> snapshot,
          ) {
            if (snapshot.hasData) {
              return _getPage(snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
