import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'src/config/route/app_routes.dart';
import 'src/core/resource/map_notification_service.dart';
import 'src/core/util/colors_constants.dart';
import 'src/core/util/strings.dart';
import 'src/di.dart';

void main() async {
  final Di di = Di();
  di.injectDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
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
