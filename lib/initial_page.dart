import 'package:flutter/material.dart';
import 'package:movies_app/strategy/ascending_sort_strategy.dart';
import 'package:movies_app/strategy/descending_sort_strategy.dart';
import 'package:movies_app/util/colors_constants.dart';
import 'package:movies_app/util/numbers.dart';
import 'movie_api_service.dart';
import 'movie_data_base.dart';
import 'use_case/movie_use_case.dart';
import 'use_case/popularity_movie_use_case.dart';
import 'util/strings.dart';

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
                  horizontal: Numbers.initialPagePaddingHorizontal,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      sortingWay = !sortingWay;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsConstants.appThemeColor,
                  ),
                  child: Text(
                    sortingWay ? textAscending : textDescending,
                    style: const TextStyle(
                      fontSize: Numbers.initialPageTextSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: Numbers.initialPageSizedBox,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Strings.homeRoute,
                    arguments: {
                      Strings.argumentTitle: Strings.movieUseCaseTitle,
                      Strings.argumentData: MovieUseCase(
                        movieApiService: MovieApiService(),
                        movieDataBase: MovieDatabase.instance,
                        sortingStrategyInterface: sortingWay
                            ? AscendingSortStrategy()
                            : DescendingSortStrategy(),
                      ),
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsConstants.appThemeColor,
                ),
                child: const Text(
                  Strings.movieUseCaseTitle,
                  style: TextStyle(
                    fontSize: Numbers.initialPageTextSize,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: Numbers.initialPageSizedBox,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Strings.homeRoute,
                    arguments: {
                      Strings.argumentTitle:
                          Strings.popularityMovieUseCaseTitle,
                      Strings.argumentData: PopularityMovieUseCase(
                        movieApiService: MovieApiService(),
                        movieDataBase: MovieDatabase.instance,
                        sortingStrategyInterface: sortingWay
                            ? AscendingSortStrategy()
                            : DescendingSortStrategy(),
                      ),
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsConstants.appThemeColor,
                ),
                child: const Text(
                  Strings.popularityMovieUseCaseTitle,
                  style: TextStyle(
                    fontSize: Numbers.initialPageTextSize,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
