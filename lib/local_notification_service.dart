import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void init() async {
    AndroidInitializationSettings android = AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    );

    DarwinInitializationSettings ios = DarwinInitializationSettings();

    InitializationSettings settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    await flutterLocalNotificationsPlugin.initialize(settings: settings);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions();
  }
}
