import 'package:flutter/material.dart';
import 'package:movies_app/util/colors_constants.dart';
import 'package:movies_app/util/numbers.dart';
import 'movie_api_service.dart';
import 'movie_data_base.dart';
import 'use_case/movie_use_case.dart';
import 'use_case/popularity_movie_use_case.dart';
import 'util/strings.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({
    Key? key,
    required this.title,
  }) : super(
          key: key,
        );

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Strings.homeRoute,
                    arguments: {
                      Strings.argumentTitle: Strings.movieUseCaseTitle,
                      Strings.argumentData: MovieUseCase(
                        movieApiService: MovieApiService(),
                        movieDataBase: MovieDatabase(),
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
                        movieDataBase: MovieDatabase(),
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
