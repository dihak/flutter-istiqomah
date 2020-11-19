import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future initializeNotification() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_stat');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  });

  tz.initializeTimeZones();
}

class NotificationModel {
  static final FlutterLocalNotificationsPlugin notif =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'habit-notif', 'Pengingat', 'Pengingat aktivitas harian',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          color: Colors.blue);

  static const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  static Future<void> showNotification(String title, String body) async {
    await notif.show(0, title, body, platformChannelSpecifics,
        payload: 'item x');
  }

  static scheduleNotification({
    int id,
    String title,
    String body,
    Time time,
    List<int> weeklist,
  }) async {
    DateTime now = DateTime.now();
    DateTime schedule = DateTime.utc(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    int firstWeek = weeklist != null ? weeklist[0] : 0;
    schedule.add(new Duration(days: now.weekday - firstWeek));

    DateTimeComponents repeat = DateTimeComponents.time;

    if (weeklist.length != 7) {
      repeat = DateTimeComponents.dayOfWeekAndTime;
    }

    print(repeat);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      schedule,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: repeat,
    );
  }
}
