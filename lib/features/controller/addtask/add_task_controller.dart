// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:tasky/core/constant/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/data/models/task_model.dart';

class AddTaskController extends ChangeNotifier {
  final GlobalKey<FormState> formKeytask = GlobalKey<FormState>();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();
  bool isHighPriority = true;

  Future<void> addTask(BuildContext context) async {
    if (formKeytask.currentState?.validate() ?? false) {
      //save data
      //check by key=>'tasks'->String
      final taskjson = PreferencesManager().getString(StorageKey.tasks);
      // initialize list of dynami
      List<dynamic> listtasks = []; //List<Map<String, dynamic<>>
      //it is not empty
      if (taskjson != null) {
        //converted to list
        listtasks = jsonDecode(taskjson);
      }
      //listtasks.length =1=>1+1
      TaskModel model = TaskModel(
        // id: listtasks.length + 1,
        id: listtasks.length + 1,

        taskName: taskNameController.text,
        taskDescription: taskDescriptionController.text,
        isHighPriority: isHighPriority,
      );
      //list of Map
      listtasks.add(model.toJson());
      //convert to String
      final taskencode = jsonEncode(listtasks);

      await PreferencesManager().setString(StorageKey.tasks, taskencode);

      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
