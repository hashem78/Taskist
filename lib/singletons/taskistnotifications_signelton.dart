import 'package:Taskist/models/taskpriority_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TaskistNotifications {
  Future<void> scheduleNotification(String title, TaskPriority priority) async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));
    var tm = DateTime.now().toString();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      tm,
      'taskist_notification-$tm',
      'Incoming!',
      icon: 'ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
      priority: (priority is LowTaskPriority)
          ? Priority.Low
          : (priority is MediumTaskPriority) ? Priority.High : Priority.Max,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      0,
      title,
      'priority: $priority',
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );
  }

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void _initNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initSetttings,
    );
  }

  static final TaskistNotifications _localNotificationsProvider =
      TaskistNotifications._internal();

  factory TaskistNotifications() {
    _initNotifications();
    return _localNotificationsProvider;
  }
  TaskistNotifications._internal();
}
