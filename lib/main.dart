import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/util/strings.dart';
import 'app_routes.dart';
import 'di.dart';
import 'util/colors_constants.dart';

void main() {
  final Di di = Di();
  di.injectDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(
      const MyApp(),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: ColorsConstants.appThemeColor,
        ),
      ),
      initialRoute: Strings.initialRoute,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
