import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/data/models/task_model.dart';
import 'package:tasky/features/widget/custom_loading.dart';
import 'package:tasky/features/widget/task_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> highPriorityTasks = [];
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    _loadtask();
  }

  void _loadtask() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isloading = true;
    });
    final finalTasks = PreferencesManager().getString('tasks');
    if (finalTasks != null) {
      final taskaftedecode = jsonDecode(finalTasks) as List<dynamic>;

      setState(() {
        highPriorityTasks =
            taskaftedecode
                .map((e) => TaskModel.fromJson(e))
                .where((e) => e.isHighPriority)
                .toList();
        highPriorityTasks = highPriorityTasks.reversed.toList();
        isloading = false;
      });
    }
    setState(() {
      isloading = false;
    });
  }

  _deleteTask(String? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;
    final finalTasks = PreferencesManager().getString('tasks');
    if (finalTasks != null) {
      final taskaftedecode = jsonDecode(finalTasks) as List<dynamic>;
      tasks = taskaftedecode.map((e) => TaskModel.fromJson(e)).toList();
      tasks.removeWhere((element) => element.id == id);
    }

    setState(() {
      highPriorityTasks.removeWhere((element) => element.id == id);
    });
    final updateTasks = highPriorityTasks.map((e) => e.toJson()).toList();
    await PreferencesManager().setString('tasks', jsonEncode(updateTasks));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('High Priority')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            isloading
                ? Center(child: CustomLoadingIndicator())
                : TaskListWidget(
                  svgPath: 'assets/svg/file.svg',

                  tasks: highPriorityTasks,
                  onDelete: (String? id) {
                    _deleteTask(id);
                  },

                  onTap: (value, index) async {
                    setState(() {
                      highPriorityTasks[index!].isDone = value ?? false;
                    });

                    final allData = PreferencesManager().getString('tasks');
                    if (allData != null) {
                      List<TaskModel> allDataList =
                          (jsonDecode(allData) as List)
                              .map((e) => TaskModel.fromJson(e))
                              .toList();
                      final int newIndex = allDataList.indexWhere(
                        (element) => element.id == highPriorityTasks[index!].id,
                      );
                      allDataList[newIndex] = highPriorityTasks[index!];
                      await PreferencesManager().setString(
                        'tasks',
                        jsonEncode(allDataList),
                      );
                      _loadtask();
                    }
                  },
                  emptyMessage: 'No Tasks',
                ),
      ),
    );
  }
}
