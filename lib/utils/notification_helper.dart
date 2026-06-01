import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final NotificationHelper _instance = NotificationHelper._internal();

  factory NotificationHelper() => _instance;

  NotificationHelper._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(android: android);

    await flutterLocalNotificationsPlugin.initialize(settings);
  }

  Future<void> showNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'restaurant_channel',
      'Restaurant Reminder',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Lunch Reminder',
      'Time to explore restaurants for lunch!',
      details,
    );
  }
}
