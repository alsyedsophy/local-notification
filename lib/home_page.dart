import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_notification/local_notification_service.dart';
import 'package:local_notification/notification_details_screen.dart';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    listenToNotification();
  }

  void listenToNotification() {
    LocalNotificationService.streamController.stream.listen((
      notificationResponse,
    ) {
      log(notificationResponse.id!.toString());
      log(notificationResponse.payload!.toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              NotificationDetailsScreen(response: notificationResponse),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Flutter Local Notifications"),
        leading: Icon(Icons.notifications),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              onTap: () {
                LocalNotificationService.showBasicNotification();
              },
              leading: Icon(Icons.notifications),
              title: Text("Basic notification"),
              trailing: IconButton(
                onPressed: () {
                  LocalNotificationService.calcleNotification(0);
                },
                icon: Icon(Icons.cancel, color: Colors.red),
              ),
            ),
            SizedBox(height: 40),
            ListTile(
              onTap: () {
                LocalNotificationService.showRepeatedNotification();
              },
              leading: Icon(Icons.notifications),
              title: Text("Repeated notification"),
              trailing: IconButton(
                onPressed: () {
                  LocalNotificationService.calcleNotification(1);
                },
                icon: Icon(Icons.cancel, color: Colors.red),
              ),
            ),
            SizedBox(height: 40),
            ListTile(
              onTap: () {
                LocalNotificationService.showScheduledNotification();
              },
              leading: Icon(Icons.notifications),
              title: Text("Schduled notification"),
              trailing: IconButton(
                onPressed: () {
                  LocalNotificationService.calcleNotification(2);
                },
                icon: Icon(Icons.cancel, color: Colors.red),
              ),
            ),
            SizedBox(height: 40),
            ListTile(
              onTap: () {
                LocalNotificationService.showScheduledDailyNotification();
              },
              leading: Icon(Icons.notifications),
              title: Text("Schduled Daily notification"),
              trailing: IconButton(
                onPressed: () {
                  LocalNotificationService.calcleNotification(3);
                },
                icon: Icon(Icons.cancel, color: Colors.red),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                LocalNotificationService.calcleAllNotifications();
              },
              child: Text("Cancel All"),
            ),
          ],
        ),
      ),
    );
  }
}
