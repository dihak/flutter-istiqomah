import 'package:flutter/material.dart';
import 'package:istiqomah/models/habitDB.dart';

class Habit {
  Habit({this.id, @required this.name, data}) : this.data = data ?? [];

  int id;
  String name;
  List<String> data;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Habit.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    data = map['data'];
  }

  bool toggelDate(DateTime date) {
    final String dateString = date.toString().substring(0, 10);
    final int index = data.indexOf(dateString);
    if (index == -1) {
      data.add(dateString);
      return true;
    } else {
      data.remove(dateString);
      return false;
    }
  }
}

class HabitModel extends ChangeNotifier {
  final List<Habit> _habits = [];
  final HabitDbProvider db;

  /// Load Habits
  HabitModel() : db = HabitDbProvider.db {
    db.getAllHabits().then((value) {
      _habits.addAll(value);
      notifyListeners();
    });
  }

  /// Get habit
  List<Habit> get habits => _habits;

  /// Add habit
  void add({@required name}) {
    db.insert(name).then((value) {
      _habits.add(value);
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
  }

  /// Save order state
  void reorderHabit(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Habit element = _habits.removeAt(oldIndex);
    _habits.insert(newIndex, element);
    final List habitIndex = _habits.map((e) => e.id).toList();
    db.saveOrderState(habitIndex);
    notifyListeners();
  }
}
