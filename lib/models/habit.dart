import 'package:flutter/material.dart';
import 'package:istiqomah/widgets/habits/habits.dart';

class HabitModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Habit> _items = [
    Habit(name: 'Sholat Shubuh di Masjid', data: [13, 14, 15, 17]),
    Habit(name: 'Sholat Dzuhur di Masjid'),
  ];

  /// Get habit
  get habit => _items;

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
}
