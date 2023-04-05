import 'package:flutter/material.dart';
import '../../core/util/strings.dart';
import '../../presentation/view/home_page.dart';
import '../../presentation/view/images_page.dart';
import '../../presentation/view/initial_page.dart';
import '../../presentation/widget/movie_text.dart';

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
      case Strings.imagesRoute:
        return MaterialPageRoute(
          builder: (_) => ImagesPage(
            title: Strings.imagesPageTitle,
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
