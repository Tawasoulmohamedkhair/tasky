// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:tasky/core/constant/storage_key.dart';
// import 'package:tasky/core/services/preferences_manager.dart';
// import 'package:tasky/data/models/task_model.dart';

// class TaskController extends ChangeNotifier {
//   bool isLoading = false;

//   List<TaskModel> todoTasks = [];
//   List<TaskModel> completeTasks = [];
//   List<TaskModel> tasks = [];
//   List<TaskModel> highPriorityTasks = [];
//   int totalDoneTasks = 0;
//   double percent = 0;
//   int totalTask = 0;

//   init() {
//     loadTask();
//   }

//   void loadTask() async {
//     isLoading = true;

//     final finalTask = PreferencesManager().getString(StorageKey.tasks);
//     if (finalTask != null) {
//       final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

//       tasks =
//           taskAfterDecode
//               .map((element) => TaskModel.fromJson(element))
//               .toList();
//       calculatePercent();
//     }

//     todoTasks = tasks.where((e) => !e.isDone).toList();
//     completeTasks = tasks.where((e) => e.isDone).toList();
//     highPriorityTasks = tasks.where((e) => e.isHighPriority).toList();
//     highPriorityTasks = highPriorityTasks.reversed.toList();

//     isLoading = false;

//     notifyListeners();
//   }

//   void donetask(bool? value, int? index) async {
//     tasks[index!].isDone = value ?? false;
//     calculatePercent();

//     final updatedTask = tasks.map((element) => element.toJson()).toList();
//     PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));

//     notifyListeners();
//   }

//   void doneTodotask(bool? value, int? index) async {
//     if (index == null) return;
//     todoTasks[index].isDone = value ?? false;
//     calculatePercent();

//     final int newIndex = tasks.indexWhere(
//       (element) => element.id == todoTasks[index].id,
//     );
//     tasks[newIndex] = todoTasks[index];
//     await PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
//     loadTask();

//     notifyListeners();
//   }

//   void donecompletetask(bool? value, int? index) async {
//     if (index == null) return;
//     completeTasks[index].isDone = value ?? false;

//     final int newIndex = tasks.indexWhere(
//       (element) => element.id == completeTasks[index].id,
//     );
//     tasks[newIndex] = completeTasks[index];
//     await PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
//     loadTask();
//   }

//   void donehighPriorityTasks(bool? value, int? index) async {
//     if (index == null) return;
//     highPriorityTasks[index].isDone = value ?? false;

//     final int newIndex = tasks.indexWhere(
//       (element) => element.id == highPriorityTasks[index].id,
//     );
//     tasks[newIndex] = highPriorityTasks[index];
//     await PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
//     loadTask();
//   }

//   calculatePercent() {
//     totalTask = tasks.length;
//     totalDoneTasks = tasks.where((e) => e.isDone).length;
//     percent = totalTask == 0 ? 0 : totalDoneTasks / totalTask;
//   }

//   deleteTask(int? id) async {
//     if (id == null) return;

//     tasks.removeWhere((e) => e.id == id);

//     todoTasks.removeWhere((task) => task.id == id);
//     completeTasks.removeWhere((task) => task.id == id);
//     highPriorityTasks.removeWhere((task) => task.id == id);

//     final updatedTask = tasks.map((element) => element.toJson()).toList();
//     PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
//     calculatePercent();

//     notifyListeners();
//   }

//   doneTask(bool? value, int? index) async {
//     tasks[index!].isDone = value ?? false;
//     calculatePercent();

//     final updatedTask = tasks.map((element) => element.toJson()).toList();
//     PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));

//     notifyListeners();
//   }
// }

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tasky/core/constant/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/data/models/task_model.dart';

class TaskController extends ChangeNotifier {
  bool isLoading = false;

  List<TaskModel> tasks = [];
  List<TaskModel> completeTasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> highPriorityTasks = [];

  int totalTask = 0;
  int totalDoneTasks = 0;
  double percent = 0;

  init() {
    _loadTasks();
  }

  void _loadTasks() {
    isLoading = true;

    final finalTask = PreferencesManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks =
          taskAfterDecode
              .map((element) => TaskModel.fromJson(element))
              .toList();

      todoTasks = tasks.where((element) => !element.isDone).toList();
      completeTasks = tasks.where((element) => element.isDone).toList();

      highPriorityTasks =
          tasks.where((element) => element.isHighPriority).toList();

      highPriorityTasks = highPriorityTasks.reversed.toList();

      calculatePercent();
    }

    isLoading = false;

    notifyListeners();
  }

  void doneTask(bool? value, int? index) async {
    tasks[index!].isDone = value ?? false;
    calculatePercent();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));

    notifyListeners();
  }

  void doneTodoTask(bool? value, int? index) async {
    if (index == null) return;
    todoTasks[index].isDone = value ?? false;
    calculatePercent();

    final int newIndex = tasks.indexWhere((e) => e.id == todoTasks[index].id);
    tasks[newIndex] = todoTasks[index];

    await PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
  }

  void doneCompleteTask(bool? value, int? index) async {
    if (index == null) return;

    // 🛡️ حماية من RangeError
    if (completeTasks.isEmpty || index < 0 || index >= completeTasks.length) {
      return;
    }

    completeTasks[index].isDone = value ?? false;

    final int newIndex = tasks.indexWhere(
      (e) => e.id == completeTasks[index].id,
    );

    // 🛡️ حماية ثانية
    if (newIndex == -1) return;

    tasks[newIndex] = completeTasks[index];
    completeTasks.removeAt(index);  

    await PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));

    _loadTasks();
  }

  void donehighPriorityTasks(bool? value, int? index) async {
    if (index == null) return;
    highPriorityTasks[index].isDone = value ?? false;

    final int newIndex = tasks.indexWhere(
      (e) => e.id == highPriorityTasks[index].id,
    );
    tasks[newIndex] = highPriorityTasks[index];

    await PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
  }

  deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((e) => e.id == id);
    todoTasks.removeWhere((task) => task.id == id);
    completeTasks.removeWhere((task) => task.id == id);
    highPriorityTasks.removeWhere((tasks) => tasks.id == id);

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));

    calculatePercent();

    notifyListeners();
  }

  calculatePercent() {
    totalTask = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : totalDoneTasks / totalTask;
  }
}
