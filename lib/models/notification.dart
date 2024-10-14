import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:istiqomah/models/habit.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future initializeNotification(BuildContext context) async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_stat');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.payload != null) {
        if (response.payload!.startsWith('habit-')) {
          int habitID = int.parse(response.payload!.substring(6));
          Habit habit = await habitAdapter.getById(habitID);
          Navigator.pushNamed(
            context,
            '/detail',
            arguments: habit,
          );
        }
      }
    },
  );

  tz.initializeTimeZones();
  String currentTimeZone = await FlutterTimezone
      .getLocalTimezone(); // Use flutter_timezone to get device timezone
  tz.setLocalLocation(tz.getLocation(currentTimeZone));

  // Request notification permissions for Android 13 or higher
  final androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  await androidImplementation?.requestNotificationsPermission();

  // Create the notification channel
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'habit-notif',
    'Reminder',
    description: 'Daily Activity Reminder',
    importance: Importance.max,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

class NotificationModel {
  static final FlutterLocalNotificationsPlugin notif =
      FlutterLocalNotificationsPlugin();

  static AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails('habit-notif', 'Reminder',
          channelDescription: 'Daily Activity Reminder',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          color: Colors.blue);

  static NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  static Future<void> rescheduleNotification(Habit habit) async {
    int notifId = (habit.id! * 7) - 7;
    // Cancel all schedule
    for (var i = 0; i < 7; i++) {
      await notif.cancel(notifId + i);
    }

    if (habit.time == null || habit.daylist!.isEmpty) return;

    // Re-schedule
    for (var item in habit.daylist!) {
      tz.TZDateTime newSchedule = _nextInstanceOfDay(habit.time!, item);
      try {
        await notif.zonedSchedule(
          notifId + (item - 1),
          habit.name!,
          'Do not forget to Complete ${habit.name} today!!',
          newSchedule,
          platformChannelSpecifics,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          payload: 'habit-${habit.id}',
        );
      } catch (e) {
        print('Error scheduling notification: $e');
      }
    }
  }

  static tz.TZDateTime _nextInstanceOfDay(TimeOfDay time, int day) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    while (scheduledDate.weekday != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    return scheduledDate;
  }

  static removeNotification(Habit habit) async {
    int notifId = (habit.id! * 7) - 7;
    // Cancel all schedule
    for (var i = 0; i < 7; i++) {
      await notif.cancel(notifId + i);
    }
  }
}
