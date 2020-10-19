import 'package:flutter/material.dart';

class Habit {
  const Habit({@required this.name, @required this.data});
  final String name;
  final List data;

  void toggelDate(int date) {
    final int index = data.indexOf(date);
    if (index == -1) {
      data.add(date);
    } else {
      data.remove(date);
    }
  }
}

class HabitModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Habit> _items = [
    Habit(name: 'Sholat Shubuh di Masjid', data: [13, 14, 15, 17]),
    Habit(name: 'Sholat Dzuhur di Masjid', data: []),
  ];

  /// Get habit
  List<Habit> get habit => _items;

  /// Add habit
  void add(Habit item) {
    _items.add(item);
    notifyListeners();
  }

  /// Removes all items from the habit
  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  /// Removes all items from the habit
  void update() {
    notifyListeners();
  }

  /// Toggle date on index
  void toggleDate(int index, int date) {
    final int indexdata = _items[index].data.indexOf(date);
    if (indexdata == -1) {
      _items[index].data.add(date);
    } else {
      _items[index].data.remove(date);
    }
    notifyListeners();
  }

  /// Removes habit by index
  void removeHabit(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
