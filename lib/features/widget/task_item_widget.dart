import 'package:flutter/material.dart';
import 'package:tasky/core/enums/task_action_items_enums.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_checkbox.dart';
import 'package:tasky/data/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
  });
  final TaskModel model;

  final Function(bool?) onChanged;
  final Function(int? id) onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,

        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              ThemeController.isDark() ? Colors.transparent : Color(0xffD1DAD6),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),

          CustomCheckbox(
            value: model.isDone,
            onChanged: (bool? value) => onChanged(value),
          ),

          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.taskname,

                  style:
                      model.isDone
                          ? Theme.of(context).textTheme.titleLarge
                          : Theme.of(context).textTheme.displaySmall,

                  maxLines: 1,
                ),
                Text(
                  model.taskdescription,

                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          PopupMenuButton<TaskActionItemsEnum>(
            icon: Icon(
              Icons.more_vert,

              color:
                  ThemeController.isDark()
                      ? (model.isDone ? Color(0xffA0A0A0) : Color(0xffC6C6C6))
                      : (model.isDone ? Color(0xff6A6A6A) : Color(0xff3A4640)),
            ),
            onSelected: (value) {
              switch (value) {
                case TaskActionItemsEnum.markasdone:
                  {
                    onChanged(!model.isDone);
                    break;
                  }
                case TaskActionItemsEnum.delete:
                  showDialog(
                    context: context,
                    builder: (context) => _showDialog(context),
                  );
                  break;
                case TaskActionItemsEnum.edit:
                  break;
              }
            },
            itemBuilder:
                (context) =>
                    TaskActionItemsEnum.values
                        .map(
                          (e) => PopupMenuItem<TaskActionItemsEnum>(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
          ),
          
        ],
      ),
    );
  }

  _showDialog(context) {
    return AlertDialog(
      title: Text('Delete Task'),
      content: Text('Are you sure you want to delete this task?'),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Delete'),
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          onPressed: () {
            onDelete(model.id);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
