import 'package:flutter/material.dart';
import '../../core/util/numbers.dart';
import '../../core/util/strings.dart';
import '../widget/movie_button.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({
    Key? key,
    required this.title,
  }) : super(
          key: key,
        );

  final String title;

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  bool sortingWay = true;
  String textAscending = Strings.ascendingTitle;
  String textDescending = Strings.descendingTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Numbers.bigPadding,
                ),
                child: MovieButton(
                  text: sortingWay ? textAscending : textDescending,
                  onPressed: () {
                    setState(() {
                      sortingWay = !sortingWay;
                    });
                  },
                  key: const Key(
                    Strings.movieButton1TestKey,
                  ),
                ),
              ),
              const SizedBox(
                height: Numbers.initialPageSizedBox,
              ),
              MovieButton(
                text: Strings.movieUseCaseTitle,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Strings.homeRoute,
                    arguments: {
                      Strings.argumentTitle: Strings.movieUseCaseTitle,
                      Strings.argumentUseCase: true,
                      Strings.argumentSortingWay: sortingWay,
                    },
                  );
                },
              ),
              const SizedBox(
                height: Numbers.initialPageSizedBox,
              ),
              MovieButton(
                text: Strings.popularityMovieUseCaseTitle,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Strings.homeRoute,
                    arguments: {
                      Strings.argumentTitle:
                          Strings.popularityMovieUseCaseTitle,
                      Strings.argumentUseCase: false,
                      Strings.argumentSortingWay: sortingWay,
                    },
                  );
                },
              ),
              const SizedBox(
                height: Numbers.initialPageSizedBox,
              ),
              MovieButton(
                text: Strings.imagesPageButtonTitle,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Strings.imagesRoute,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
