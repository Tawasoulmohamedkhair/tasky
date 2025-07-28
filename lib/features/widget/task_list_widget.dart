import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/data/models/task_model.dart';
import 'package:tasky/features/widget/task_item_widget.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onDelete,
    required this.emptyMessage,
    required this.svgPath,
  });
  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function(String ? ) onDelete;

  final String emptyMessage;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSvgPicture(svgAssetPath: svgPath),
              SizedBox(height: 10),
              Text(emptyMessage, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        )
        : ListView.separated(
          padding: EdgeInsets.only(bottom: 60),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return TaskItemWidget(
              model: tasks[index],
              onChanged: (bool? value) {
                onTap(value, index);
              },
              onDelete: (String? id) {
                onDelete(id);
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        );
  }
}
