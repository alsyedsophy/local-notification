import 'package:flutter/material.dart';
import 'package:local_notification/home_page.dart';
import 'package:local_notification/local_notification_service.dart';
import 'package:local_notification/work_manager_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    LocalNotificationService.init(),
    WorkManagerService().init(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Local Notifications',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: HomePage(),
    );
  }
}
