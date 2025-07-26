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

  // _deleteTask(int? id) async {
  //   if (id == null) return;

  //   final finalTasks = PreferencesManager().getString('tasks');
  //   if (finalTasks == null) return;
  //   List<TaskModel> tasks = [];

  //   final taskaftedecode = jsonDecode(finalTasks) as List<dynamic>;
  //   tasks = taskaftedecode.map((e) => TaskModel.fromJson(e)).toList();

  //   // Remove the task with the given id from the full list
  //   tasks.removeWhere((element) => element.id == id);

  //   // Save updated full task list
  //   await PreferencesManager().setString(
  //     'tasks',
  //     jsonEncode(tasks.map((e) => e.toJson()).toList()),
  //   );

  //   // Update the visible completeTasks list
  //   setState(() {
  //     completeTasks.removeWhere((element) => element.id == id);
  //   });
  // }

  _deleteTask(int? id) async {
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
      completeTasks.removeWhere((element) => element.id == id);
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
                      svgPath: 'assets/svg/file.svg',

                      emptyMessage: 'No Tasks',
                      tasks: completeTasks,
                      onTap: (value, index) async {
                        setState(() {
                          completeTasks[index!].isDone = value ?? false;
                        });

                        final updateTasks =
                            completeTasks.map((e) => e.toJson()).toList();
                        await PreferencesManager().setString(
                          'tasks',
                          jsonEncode(updateTasks),
                        );
                        _loadtask();
                      },
                      onDelete: (int? id) {
                        _deleteTask(id);
                      },
                      // onDelete: (index) async {
                      //   setState(() {
                      //     completeTasks.removeAt(index!);
                      //   });
                      //   final updateTasks =
                      //       completeTasks.map((e) => e.toJson()).toList();
                      //   await PreferencesManager().setString(
                      //     'tasks',
                      //     jsonEncode(updateTasks),
                      //   );
                      //   _loadtask();
                      // },
                    ),
          ),
        ),
      ],
    );
  }
}
