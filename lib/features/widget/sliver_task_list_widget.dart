import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/data/models/task_model.dart';
import 'package:tasky/features/widget/task_item_widget.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
    required this.emptyMessage,
    required this.svgPath,
  });
  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function(String?) onDelete;
  final Function onEdit;

  final String emptyMessage;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? SliverToBoxAdapter(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSvgPicture(svgAssetPath: svgPath),
                Text(
                  emptyMessage,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        )
        : SliverPadding(
          padding: const EdgeInsets.only(bottom: 80),
          sliver: SliverList.separated(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskItemWidget(
                // model: tasks[index],
                // onChanged: (bool? value) {
                //   onTap(value, index);
                // },
                // onDelete: (String? id) {
                //   onDelete(id);
                // },
                // onEdit: () => onEdit(),
                onChanged: (bool? value) {
                  onTap(value, index);
                },
                onDelete: (String? id) {
                  onDelete(id);
                },
                onEdit: () => onEdit(),

                model: tasks[index],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ),
        );
  }
}
