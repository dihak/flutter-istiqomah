import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'habit.dart';

class HabitDbProvider {
  HabitDbProvider._();
  static final HabitDbProvider db = HabitDbProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "HabitDB.db");
    // deleteDatabase(path);
    // print("Database " + path);
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE Habit ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT,"
          "time TEXT"
          ")",
        );
        await db.execute(
          "CREATE TABLE HabitReminder ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "habit_id INTEGER,"
          "weekday TEXT,"
          "FOREIGN KEY (habit_id)"
          " REFERENCES Habit (id)"
          " ON DELETE CASCADE"
          ")",
        );
        await db.execute(
          "CREATE TABLE HabitDetail ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "habit_id INTEGER,"
          "date text,"
          "FOREIGN KEY (habit_id)"
          " REFERENCES Habit (id)"
          " ON DELETE CASCADE"
          ")",
        );
        await db.execute(
          "CREATE TABLE Option ("
          "name text PRIMARY KEY,"
          "value text"
          ")",
        );
      },
      onConfigure: (Database db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<List<Habit>> getAllHabits() async {
    final db = await database;
    List<Map> results = await db.query("Habit",
        columns: ['id', 'name', 'time'], orderBy: "id ASC");
    List<Map> detail = await db.query("HabitDetail",
        columns: ['id', 'habit_id', 'date'], orderBy: "id ASC");
    List<Map> reminder = await db.query("HabitReminder",
        columns: ['id', 'habit_id', 'weekday'], orderBy: "id ASC");
    List<Habit> habits = new List();

    results.forEach((result) {
      List<String> data = detail
          .where((element) => element['habit_id'] == result['id'])
          .map<String>((e) => e['date'])
          .toList();
      Habit habit = Habit.fromMap(result);
      habit.data = data;

      if (result['time'] != null) {
        Map dataReminder = reminder.firstWhere(
          (element) => element['habit_id'] == result['id'],
        );
        List<int> day = dataReminder['weekday']
            .split(',')
            .map<int>((e) => int.parse(e))
            .toList();
        habit.reminderID = dataReminder['id'];
        habit.setDayList(day);
      }

      habits.add(habit);
    });

    // Sort order
    Map<String, dynamic> orderState = await getOrderState();
    if (orderState['value'] != '') {
      List<String> orderList = orderState['value'].split(',');
      habits.sort((a, b) {
        var indexA = orderList.indexOf(a.id.toString());
        var indexB = orderList.indexOf(b.id.toString());
        if (indexA == -1) indexA = orderList.length;
        if (indexB == -1) indexB = orderList.length;
        return indexA.compareTo(indexB);
      });
    }

    return habits;
  }

  Future<Habit> getHabitById(int id) async {
    final db = await database;
    var result = await db.query("Habit", where: "id = ?", whereArgs: [id]);
    return result.isNotEmpty ? Habit.fromMap(result.first) : Null;
  }

  Future<Habit> insert(String name, TimeOfDay time, List<int> daylist) async {
    final db = await database;

    // Insert to db
    var id = await db.insert('Habit', {
      'name': name,
      'time': time != null ? '${time.hour}:${time.minute}' : null
    });
    if (daylist != null) {
      daylist.sort();
      await db.insert('HabitReminder', {
        'habit_id': id,
        'weekday': daylist.join(','),
      });
    }

    // Return habit
    Habit habit = Habit(id: id, name: name, time: time, daylist: daylist);
    return habit;
  }

  Future<bool> toggleDate(Habit habit, DateTime date) async {
    final db = await database;
    final String dateString = date.toString().substring(0, 10);
    var result = await db.delete(
      "HabitDetail",
      where: "habit_id = ? and date = ?",
      whereArgs: [habit.id, dateString],
    );
    if (result == 0) {
      result = await db.insert(
        "HabitDetail",
        {'habit_id': habit.id, 'date': dateString},
      );
      return true;
    } else {
      return false;
    }
  }

  Future<int> update(Habit habit) async {
    final db = await database;
    var result = await db
        .update("Habit", habit.toMap(), where: "id = ?", whereArgs: [habit.id]);
    if (habit.time == null) {
      await db.delete("HabitReminder",
          where: "habit_id = ?", whereArgs: [habit.id]);
      habit.reminderID = null;
    } else if (habit.reminderID != null) {
      await db.update("HabitReminder", {'weekday': habit.daylist.join(',')},
          where: "id = ?", whereArgs: [habit.reminderID]);
    } else {
      habit.reminderID = await db.insert(
        "HabitReminder",
        {
          'habit_id': habit.id,
          'weekday': habit.daylist.join(','),
        },
      );
    }
    return result;
  }

  delete(Habit habit) async {
    final db = await database;
    db.delete("Habit", where: "id = ?", whereArgs: [habit.id]);
  }

  Future<Map<String, dynamic>> getOrderState() async {
    final db = await database;
    var result = await db.query('Option', where: "name = 'habit_order'");
    if (result.length == 0) {
      var data = {
        'name': 'habit_order',
        'value': '',
      };
      await db.insert('Option', data);
      return data;
    } else {
      return result.first;
    }
  }

  saveOrderState(List<int> indexList) async {
    final db = await database;
    var result = await db.update(
        'Option', {'name': 'habit_order', 'value': indexList.join(',')},
        where: "name = 'habit_order'");
    return result;
  }
}
