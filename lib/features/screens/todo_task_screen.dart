import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/controller/task_controller.dart';
import 'package:tasky/features/widget/custom_loading.dart';
import 'package:tasky/features/widget/task_list_widget.dart';

class TodoTaskScreen extends StatelessWidget {
  const TodoTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TaskController>();
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
                controller.isLoading
                    ? Center(child: CustomLoadingIndicator())
                    : Consumer<TaskController>(
                      builder: (context, value, child) {
                        return TaskListWidget(
                          svgPath: 'assets/svg/file.svg',

                          emptyMessage: 'No Tasks',
                          tasks: value.todoTasks,
                          onTap: (value, index) async {
                            controller.doneTodoTask(value, index);
                          },
                          onDelete: (int? id) {
                            controller.deleteTask(id);
                          },
                          onEdit: () {
                            controller.init();
                          },
                        );
                      },
                    ),
          ),
        ),
      ],
    );
  }
}
