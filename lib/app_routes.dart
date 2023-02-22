import 'package:flutter/material.dart';
import 'package:movies_app/movie_data_base.dart';
import 'package:movies_app/use_case/movie_use_case.dart';
import 'package:movies_app/util/strings.dart';
import 'package:movies_app/widget/movie_text.dart';
import 'home_page.dart';
import 'movie_api_service.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Strings.homeRoute:
        return MaterialPageRoute(
          builder: (_) => HomePage(
            movieUseCase: MovieUseCase(
              movieApiService: MovieApiService(),
              movieDataBase: MovieDatabase(),
            ),
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
