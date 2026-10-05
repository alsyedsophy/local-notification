import 'dart:developer';

import 'package:local_notification/local_notification_service.dart';
import 'package:workmanager/workmanager.dart';

//? Setup WorkManager For Background Taskes

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    log("Background task: $taskName");
    LocalNotificationService.showBasicNotification();
    return Future.value(true);
  });
}

class WorkManagerService {
  Future<void> registerMyTask() async {
    await Workmanager().registerOneOffTask("id 1", "Show Simple Notification");
  }

  // Initialization
  Future<void> init() async {
    await Workmanager().initialize(callbackDispatcher);
    await registerMyTask();
  }

  void cancle(String id) {
    Workmanager().cancelByUniqueName(id);
  }
}
