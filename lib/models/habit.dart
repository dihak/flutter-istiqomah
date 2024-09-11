import 'dart:async';

import 'package:flutter/material.dart';
import 'package:istiqomah/models/habitDB.dart';

import 'notification.dart';

class Habit {
  Habit({
    this.id,
    required this.name,
    this.time,
    this.daylist,
    this.reminderID,
    data,
  }) : this.data = data ?? [];

  int? id;
  String? name;
  int? reminderID;
  TimeOfDay? time;
  List<int>? daylist;
  List<String?>? data;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
    };
    if (id != null) {
      map['id'] = id;
    }
    if (time != null) {
      map['time'] = '${time!.hour}:${time!.minute}';
    } else {
      map['time'] = null;
    }
    return map;
  }

  Habit.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    if (map['time'] != null) {
      int hour = int.parse(map['time'].toString().split(':')[0]);
      int minute = int.parse(map['time'].toString().split(':')[1]);
      time = TimeOfDay(hour: hour, minute: minute);
    }
    daylist = map['daylist'];
    data = map['data'];
  }

  bool toggelDate(DateTime date) {
    final String dateString = date.toString().substring(0, 10);
    final int index = data!.indexOf(dateString);
    if (index == -1) {
      data!.add(dateString);
      return true;
    } else {
      data!.remove(dateString);
      return false;
    }
  }

  Habit setDayList(List<int> day) {
    day.sort();
    this.daylist = day;
    return this;
  }
}

class HabitModel extends ChangeNotifier {
  final List<Habit> _habits = [];
  final HabitDbProvider db;
  Future? dbGetAll;

  /// Load Habits
  HabitModel() : db = HabitDbProvider.db {
    dbGetAll = db.getAllHabits().then((value) {
      _habits.addAll(value);
      notifyListeners();
    });
  }

  /// Get habit
  List<Habit> get habits => _habits;

  /// Get habit by id
  Future<Habit> getById(int id) async {
    await dbGetAll;
    return _habits.firstWhere((element) => element.id == id);
  }

  /// Add habit
  void add({required name, TimeOfDay? time, List<int>? daylist}) {
    db.insert(name, time, daylist).then((value) {
      _habits.add(value);
      NotificationModel.rescheduleNotification(value);
      notifyListeners();
    });
  }

  /// Removes all items from the habit
  void removeAll() {
    _habits.clear();
    notifyListeners();
  }

  /// Removes all items from the habit
  void update(Habit habit) {
    db.update(habit).then((value) => notifyListeners());
    NotificationModel.rescheduleNotification(habit);
  }

  /// Toggle date on index
  void toggleDate(Habit habit, DateTime date) {
    db.toggleDate(habit, date).then((value) {
      habit.toggelDate(date);
      notifyListeners();
    });
  }

  /// Removes habit
  void remove(Habit habit) {
    db.delete(habit).then((value) {
      _habits.remove(habit);
      notifyListeners();
    });
    NotificationModel.removeNotification(habit);
  }

  /// Save order state
  void reorderHabit(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Habit element = _habits.removeAt(oldIndex);
    _habits.insert(newIndex, element);
    final List habitIndex = _habits.map((e) => e.id).toList();
    db.saveOrderState(habitIndex as List<int?>);
    notifyListeners();
  }
}

final HabitModel habitAdapter = new HabitModel();
