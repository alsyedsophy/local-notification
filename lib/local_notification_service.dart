import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static StreamController<NotificationResponse> streamController =
      StreamController();

  static onTap(NotificationResponse notificationResponce) {
    streamController.add(notificationResponce);
  }

  static void init() async {
    AndroidInitializationSettings android = AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    );

    DarwinInitializationSettings ios = DarwinInitializationSettings();

    InitializationSettings settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: settings,
      onDidReceiveBackgroundNotificationResponse: onTap,
      onDidReceiveNotificationResponse: onTap,
    );

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

  //? Basic notification

  static Future<void> showBasicNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id 0",
        "Basic Notification",
        channelDescription: "General Notification",
        importance: Importance.high,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound(
          'notification_sound'.split('.').first,
        ),
      ),
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      id: 0,
      title: "Basic",
      body: "Basic Notification",
      payload: "Basic Notification Payload",
      notificationDetails: details,
    );
  }

  //? Repeated notification

  static Future<void> showRepeatedNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id 1",
        "Repeated Notification",
        channelDescription: "General Notification",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.periodicallyShow(
      id: 1,
      title: "Repeated",
      body: "Repeated Notification",
      repeatInterval: RepeatInterval.everyMinute,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: "Repeated Notification Payload",
      notificationDetails: details,
    );
  }
  //? Scheduled notification

  static Future<void> showScheduledNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id 2",
        "Scheduled Notification",
        channelDescription: "General Notification",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    // initialization Area
    tz.initializeTimeZones();
    try {
      final TimezoneInfo timeZoneName =
          await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName.localizedName!.name));
    } catch (e) {
      tz.setLocalLocation(tz.getLocation('Africa/Cairo')); // افتراضي
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: 2,
      title: "Scheduled",
      body: "Scheduled Notification",
      scheduledDate: tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: "Scheduled Notification Payload",
      notificationDetails: details,
    );
  }

  //? Cancle Notification By Id

  static void calcleNotification(int id) {
    flutterLocalNotificationsPlugin.cancel(id: id);
  }

  //? Cancle All Notifications

  static void calcleAllNotifications() {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}
