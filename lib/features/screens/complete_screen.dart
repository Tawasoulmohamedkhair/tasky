import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/data/models/task_model.dart';
import 'package:tasky/features/widget/custom_loading.dart';
import 'package:tasky/features/widget/task_list_widget.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  bool isloading = false;
  List<TaskModel> completeTasks = [];

  @override
  void initState() {
    super.initState();
    _loadtask();
  }

  void _loadtask() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isloading = true;
    });
    final finalTasks = PreferencesManager().getString('tasks');
    if (finalTasks != null) {
      final taskaftedecode = jsonDecode(finalTasks) as List<dynamic>;

      setState(() {
        completeTasks =
            taskaftedecode
                .map((e) => TaskModel.fromJson(e))
                .where((e) => e.isDone)
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

    // Load the full task list from preferences
    final finalTasks = PreferencesManager().getString('tasks');
    if (finalTasks != null) {
      List<TaskModel> allTasks = [];
      // Decode JSON into a full task list
      final taskAfterDecode = jsonDecode(finalTasks) as List<dynamic>;
      allTasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();

      // Remove the task with matching ID
      allTasks.removeWhere((task) => task.id == id);

      // Save the updated full task list back to preferences
      final updatedJson = allTasks.map((e) => e.toJson()).toList();
      await PreferencesManager().setString('tasks', jsonEncode(updatedJson));

      // Also update the local completed list for immediate UI refresh
      setState(() {
        completeTasks.removeWhere((task) => task.id == id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'Completed Tasks',
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
                      onDelete: (String? id) {
                        _deleteTask(id);
                      },
                      onEdit: () {
                        _loadtask();
                      },
                      svgPath: 'assets/svg/file.svg',

                      emptyMessage: 'No Tasks',
                      tasks: completeTasks,

                      onTap: (value, index) async {
                        final finalTasks = PreferencesManager().getString(
                          'tasks',
                        );
                        if (finalTasks != null) {
                          List<TaskModel> allTasks =
                              (jsonDecode(finalTasks) as List)
                                  .map((e) => TaskModel.fromJson(e))
                                  .toList();

                          final currentTask = completeTasks[index!];

                          // Find and update the correct task in the full list
                          final fullListIndex = allTasks.indexWhere(
                            (e) => e.id == currentTask.id,
                          );
                          if (fullListIndex != -1) {
                            allTasks[fullListIndex] = allTasks[fullListIndex]
                                .copyWith(isDone: value ?? false);
                          }

                          // Save the updated full list
                          final updatedJson =
                              allTasks.map((e) => e.toJson()).toList();
                          await PreferencesManager().setString(
                            'tasks',
                            jsonEncode(updatedJson),
                          );

                          // Refresh completed tasks only
                          _loadtask();
                        }
                      },
                    ),
          ),
        ),
      ],
    );
  }
}
