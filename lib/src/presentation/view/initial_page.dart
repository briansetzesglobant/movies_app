import 'package:flutter/material.dart';
import '../../core/util/colors_constants.dart';
import '../../core/util/numbers.dart';
import '../../core/util/strings.dart';

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
                  key: const Key('elevated-button-1'),
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
                      Strings.argumentUseCase: true,
                      Strings.argumentSortingWay: sortingWay,
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
                      Strings.argumentUseCase: false,
                      Strings.argumentSortingWay: sortingWay,
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
