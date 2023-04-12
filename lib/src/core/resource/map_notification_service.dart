import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:movies_app/src/core/util/numbers.dart';
import 'package:movies_app/src/core/util/strings.dart';

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings(Strings.mapNotificationIcon);

  const InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitializationSettings);

  await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> showNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
          Strings.mapNotificationChannelId, Strings.mapNotificationChannelName,
          importance: Importance.max, priority: Priority.high);

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  await _flutterLocalNotificationsPlugin.show(
      Numbers.mapNotificationId,
      Strings.mapNotificationTitle,
      Strings.mapNotificationBody,
      notificationDetails);
}
