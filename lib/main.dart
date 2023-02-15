import 'package:flutter/material.dart';
import 'home_page.dart';
import 'movie_api_service.dart';
import 'util/colors_constants.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        color: ColorsConstants.appThemeColor,
      )),
      home: HomePage(
        movieApiService: MovieApiService(),
      ),
    );
  }
}
