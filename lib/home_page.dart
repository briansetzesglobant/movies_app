import 'package:flutter/material.dart';
import 'package:movies_app/movie_card.dart';
import 'package:movies_app/movie_api_service.dart';
import 'package:movies_app/util/numbers.dart';
import 'model/movies_list.dart';
import 'util/strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.movieApiService,
  }) : super(
          key: key,
        );

  final MovieApiService movieApiService;

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
          future: movieApiService.getMoviesList(),
          builder: (
            context,
            AsyncSnapshot<MoviesList> snapshot,
          ) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data?.results.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Numbers.homePageCrossAxisCount,
                ),
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  return GridTile(
                    child: MovieCard(
                      title: snapshot.data!.results[index].title,
                      image:
                          '${Strings.imageNetwork}${snapshot.data!.results[index].posterPath}',
                    ),
                  );
                },
              );
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
