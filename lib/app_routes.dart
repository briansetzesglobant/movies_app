import 'package:flutter/material.dart';
import 'package:movies_app/bloc/movie_bloc.dart';
import 'package:movies_app/use_case/use_case_interface.dart';
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
            blocInterface: MovieBloc(
              useCaseInterface: (settings.arguments!
                  as Map<String, dynamic>)[Strings.argumentData],
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
