import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/controller/task_controller.dart';
import 'package:tasky/features/widget/custom_loading.dart';
import 'package:tasky/features/widget/task_list_widget.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});
 @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TaskController>(context);
    return Scaffold(
      appBar: AppBar(title: Text('High Priority')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            controller.isLoading
                ? Center(child: CustomLoadingIndicator())
                : Consumer<TaskController>(
                  builder: (context, value, child) {
                    return TaskListWidget(
                      svgPath: 'assets/svg/file.svg',

                      tasks: value.highPriorityTasks,
                      onDelete: (int? id) {
                        controller.deleteTask(id);
                      },
                      onEdit: () {
                        controller.init();
                      },

                      onTap: (value, index) async {
                        controller.donehighPriorityTasks(value, index);
                      },
                      emptyMessage: 'No Tasks',
                    );
                  },
                ),
      ),
    );
  }
}
