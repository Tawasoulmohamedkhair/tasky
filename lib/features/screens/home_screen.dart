import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/data/models/task_model.dart';
import 'package:tasky/features/screens/add_task.dart';
import 'package:tasky/features/widget/achieved%20_tasks_widget.dart';
import 'package:tasky/features/widget/custom_loading.dart';
import 'package:tasky/features/widget/sliver_task_list_widget.dart';
import 'package:tasky/features/widget/is_high_Priority_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username = 'Default';
  bool ischecked = false;
  List<TaskModel> task = [];
  bool isloading = false;
  int totalTask = 0;
  int totalDoneTask = 0;
  double percentage = 0;

  @override
  void initState() {
    super.initState();
    _loadusername();
    _loadtask();
  }

  void _loadusername() async {
    setState(() {
      username = PreferencesManager().getString('username') ?? '';
    });
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
        task = taskaftedecode.map((e) => TaskModel.fromJson(e)).toList();
        calculatepercentage();

        isloading = false;
      });
    }
    setState(() {
      isloading = false;
    });
  }

  calculatepercentage() {
    totalTask = task.length;
    totalDoneTask = task.where((e) => e.isDone).length;
    percentage = totalTask == 0 ? 0 : totalDoneTask / totalTask;
  }

  _doneTask(value, index) async {
    setState(() {
      task[index!].isDone = value ?? false;
      calculatepercentage();
    });
    final updateTasks = task.map((e) => e.toJson()).toList();
    await PreferencesManager().setString('tasks', jsonEncode(updateTasks));
  }

  _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;
    final finalTasks = PreferencesManager().getString('tasks');
    if (finalTasks != null) {
      final taskaftedecode = jsonDecode(finalTasks) as List<dynamic>;
      tasks = taskaftedecode.map((e) => TaskModel.fromJson(e)).toList();
      tasks.removeWhere((element) => element.id == id);
    }

    setState(() {
      task.removeWhere((element) => element.id == id);
    });
    final updateTasks = task.map((e) => e.toJson()).toList();
    await PreferencesManager().setString('tasks', jsonEncode(updateTasks));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 44,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTaskScreen()),
            );
            //if add task make refresh for screen
            if (result != null && result) {
              _loadtask();
            }
          },

          label: Text('Add New Task'),
          icon: Icon(Icons.add),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xff181818),
                          backgroundImage: AssetImage(
                            'assets/svg/extracted_person.png',
                          ),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good Evening , $username',
                              style: Theme.of(
                                context,
                              ).textTheme.displaySmall!.copyWith(fontSize: 16),
                            ),
                            Text(
                              'One task at a time.One step closer.',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.settings),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Yuhuu ,Your work Is ',

                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Row(
                      children: [
                        Text(
                          'almost done ! ',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SvgPicture.asset('assets/svg/waving-hand.svg'),
                      ],
                    ),
                    SizedBox(height: 18),
                    AchievedTasksWidget(
                      totalTask: totalTask,
                      totalDoneTask: totalDoneTask,
                      percentage: percentage,
                    ),
                    SizedBox(height: 8),

                    IsHighPriorityWidget(
                      tasks: task.where((e) => e.isHighPriority).toList(),
                      onTap: (value, index) {
                        _doneTask(value, index);
                      },
                      refresh: () {
                        _loadtask();
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 16),
                      child: Text(
                        'My Tasks',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
              isloading
                  ? Center(child: CustomLoadingIndicator())
                  : SliverTaskListWidget(
                    svgPath: 'assets/svg/file.svg',

                    emptyMessage: 'No Data',
                    tasks: task,
                    onTap: (value, index) {
                      _doneTask(value, index);
                    },
                    onDelete: (int? id) {
                      _deleteTask(id);
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
