import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:istiqomah/models/habit.dart';
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

  final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
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

  static rescheduleNotification(Habit habit) async {
    int notifId = (habit.id * 7) - 7;
    // Cancel all schedule
    for (var i = 0; i < 7; i++) {
      await notif.cancel(notifId + i);
    }

    if (habit.time == null || habit.daylist.length == 0) return;

    DateTime now = DateTime.now();
    tz.TZDateTime schedule = tz.TZDateTime.local(
      now.year,
      now.month,
      now.day,
      habit.time.hour,
      habit.time.minute,
    );

    // Re-schedule
    for (var item in habit.daylist) {
      tz.TZDateTime newSchedule =
          schedule.add(new Duration(days: item - now.weekday));
      if (newSchedule.isBefore(DateTime.now())) {
        newSchedule = newSchedule.add(new Duration(days: 7));
      }
      await notif.zonedSchedule(
          notifId + (item - 1),
          habit.name,
          'Jangan lupa ${habit.name} hari ini!',
          newSchedule,
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          payload: 'habit-${habit.id}');
    }
  }

  static removeNotification(Habit habit) async {
    int notifId = (habit.id * 7) - 7;
    // Cancel all schedule
    for (var i = 0; i < 7; i++) {
      await notif.cancel(notifId + i);
    }
  }
}
