import 'package:flutter/material.dart';
import 'package:movies_app/util/strings.dart';
import 'package:movies_app/widget/movie_text.dart';
import 'home_page.dart';
import 'initial_page.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Strings.initialRoute:
        return MaterialPageRoute(
          builder: (_) => const InitialPage(
            title: Strings.initialPageTitle,
          ),
        );
      case Strings.homeRoute:
        return MaterialPageRoute(
          builder: (_) => HomePage(
            title: (settings.arguments!
                as Map<String, dynamic>)[Strings.argumentTitle],
            useCase: (settings.arguments!
                as Map<String, dynamic>)[Strings.argumentUseCase],
            sortingWay: (settings.arguments!
                as Map<String, dynamic>)[Strings.argumentSortingWay],
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: MovieText(
              text: Strings.appRouteDefault,
            ),
          ),
        );
    }
  }
}
