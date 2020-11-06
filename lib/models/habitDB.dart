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
    print("Database " + path);
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE Habit ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT"
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
      },
      onConfigure: (Database db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<List<Habit>> getAllHabits() async {
    final db = await database;
    List<Map> results =
        await db.query("Habit", columns: ['id', 'name'], orderBy: "id ASC");
    List<Map> detail = await db.query("HabitDetail",
        columns: ['id', 'habit_id', 'date'], orderBy: "id ASC");
    List<Habit> habits = new List();

    results.forEach((result) {
      List<String> data = detail
          .where((element) => element['habit_id'] == result['id'])
          .map<String>((e) => e['date'])
          .toList();
      Habit habit = Habit.fromMap(result);
      habit.data = data;
      habits.add(habit);
    });

    return habits;
  }

  Future<Habit> getHabitById(int id) async {
    final db = await database;
    var result = await db.query("Habit", where: "id = ", whereArgs: [id]);
    return result.isNotEmpty ? Habit.fromMap(result.first) : Null;
  }

  Future<Habit> insert(String name) async {
    final db = await database;
    var id = await db.insert('Habit', {'name': name});
    var habit = Habit(id: id, name: name);
    print('Add new habit ' + name);
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
    return result;
  }

  delete(Habit habit) async {
    final db = await database;
    db.delete("Habit", where: "id = ?", whereArgs: [habit.id]);
  }
}
