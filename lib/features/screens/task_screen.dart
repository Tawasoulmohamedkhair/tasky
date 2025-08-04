import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/data/models/task_model.dart';
import 'package:tasky/features/widget/custom_loading.dart';
import 'package:tasky/features/widget/task_list_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel> todoTasks = [];
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    _loadtask();
  }

  void _loadtask() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      isloading = true;
    });
    final finalTasks = PreferencesManager().getString('tasks');
    if (finalTasks != null) {
      final taskaftedecode = jsonDecode(finalTasks) as List<dynamic>;

      setState(() {
        todoTasks =
            taskaftedecode
                .map((e) => TaskModel.fromJson(e))
                .where((e) => e.isDone == false)
                .toList();

        isloading = false;
      });
    }
    setState(() {
      isloading = false;
    });
  }

  _deleteTask(String? id) async {
    if (id == null) return;
    final finalTasks = PreferencesManager().getString('tasks');
    if (finalTasks != null) {
      List<TaskModel> tasks = [];

      final taskaftedecode = jsonDecode(finalTasks) as List<dynamic>;
      tasks = taskaftedecode.map((e) => TaskModel.fromJson(e)).toList();
      tasks.removeWhere((element) => element.id == id);
      final updateTasks = tasks.map((e) => e.toJson()).toList();
      await PreferencesManager().setString('tasks', jsonEncode(updateTasks));
    }

    setState(() {
      todoTasks.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'To Do Tasks',

            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                isloading
                    ? Center(child: CustomLoadingIndicator())
                    : TaskListWidget(
                      svgPath: 'assets/svg/file.svg',

                      emptyMessage: 'No Tasks',
                      tasks: todoTasks,
                      onTap: (value, index) async {
                        setState(() {
                          todoTasks[index!].isDone = value ?? false;
                        });
                        final allData = PreferencesManager().getString('tasks');
                        if (allData != null) {
                          List<TaskModel> allDataList =
                              (jsonDecode(allData) as List)
                                  .map((e) => TaskModel.fromJson(e))
                                  .toList();
                          final int newIndex = allDataList.indexWhere(
                            (element) => element.id == todoTasks[index!].id,
                          );
                          allDataList[newIndex] = todoTasks[index!];
                          await PreferencesManager().setString(
                            'tasks',
                            jsonEncode(allDataList),
                          );
                          _loadtask();
                        }
                      },
                      onDelete: (String? id) {
                        _deleteTask(id);
                      },
                      onEdit: () {
                        _loadtask();
                      },
                    ),
          ),
        ),
      ],
    );
  }
}
