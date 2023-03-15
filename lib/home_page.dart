import 'package:flutter/material.dart';
import 'package:movies_app/bloc/bloc_interface.dart';
import 'package:movies_app/util/assets.dart';
import 'package:movies_app/widget/movie_card.dart';
import 'package:movies_app/util/numbers.dart';
import 'data_state.dart';
import 'model/movies_list.dart';
import 'util/api_service.dart';
import 'util/strings.dart';
import 'widget/movie_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.title,
    required this.blocInterface,
  }) : super(
          key: key,
        );

  final String title;
  final BlocInterface blocInterface;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.blocInterface.getMoviesList();
  }

  @override
  void dispose() {
    widget.blocInterface.dispose();
    super.dispose();
  }

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
        title: Text(
          widget.title,
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<DataState<MoviesList>>(
          stream: widget.blocInterface.moviesListStream,
          builder: (
            BuildContext context,
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
