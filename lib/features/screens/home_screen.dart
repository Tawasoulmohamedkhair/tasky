import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/controller/home/home_controller.dart';
import 'package:tasky/features/controller/task_controller.dart';
import 'package:tasky/features/screens/add_task.dart';
import 'package:tasky/features/widget/achieved_tasks_widget.dart';
import 'package:tasky/features/widget/sliver_task_list_widget.dart';
import 'package:tasky/features/widget/is_high_Priority_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: 44,
          child: Builder(
            builder: (context) {
              return FloatingActionButton.extended(
                onPressed: () async {
                  final bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTaskScreen()),
                  );
                  //if add task make refresh for screen
                  if (result != null && result) {
                    context.read<TaskController>().init();
                    //controller.loadTask();
                  }
                },

                label: Text('Add New Task'),
                icon: Icon(Icons.add),
              );
            },
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Selector<HomeController, String?>(
                            selector:
                                (context, controller) =>
                                    controller.userImagePath,
                            builder: (
                              BuildContext context,
                              userImagePath,
                              Widget? child,
                            ) {
                              return CircleAvatar(
                                backgroundImage:
                                    userImagePath == null
                                        ? AssetImage('assets/images/person.png')
                                        : FileImage(File(userImagePath)),
                              );
                            },
                          ),

                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Selector<HomeController, String?>(
                                selector:
                                    (context, controller) =>
                                        controller.username,
                                builder: (
                                  BuildContext context,
                                  String? username,
                                  Widget? child,
                                ) {
                                  return Text(
                                    'Good Evening , $username',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(fontSize: 16),
                                  );
                                },
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
                      SizedBox(height: 20),
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
                      AchievedTasksWidget(),
                      SizedBox(height: 8),

                      IsHighPriorityWidget(),
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
                SliverTaskListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
