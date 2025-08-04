import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasky/core/enums/task_action_items_enums.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_checkbox.dart';
import 'package:tasky/core/widgets/custom_elevated_button.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/data/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });
  final TaskModel model;

  final Function(bool?) onChanged;
  final Function(String? id) onDelete;
  final Function onEdit;

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
                if (model.taskdescription.isNotEmpty)
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
            onSelected: (value) async {
              switch (value) {
                case TaskActionItemsEnum.markasdone:
                  {
                    onChanged(!model.isDone);
                    break;
                  }
                case TaskActionItemsEnum.delete:
                  _showAlertDialog(context);
                  break;
                case TaskActionItemsEnum.edit:
                  final result = await ShowBottomSheet(context, model);
                  if (result == true) {
                    onEdit();
                  }
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

  Future<String?> _showAlertDialog(context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final controller = TextEditingController(text: model.taskname);
        return AlertDialog(
          title: Text('Delete Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Text('Are you sure you want to delete this task?'),
              CustomTextFormFields(
                title: '',
                hintText: '',
                controller: controller,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                onDelete(model.id);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> ShowBottomSheet(BuildContext context, TaskModel model) {
    final GlobalKey<FormState> formKeytask = GlobalKey<FormState>();

    final TextEditingController taskNameController = TextEditingController(
      text: model.taskname,
    );
    final TextEditingController taskDescriptionController =
        TextEditingController(text: model.taskdescription);
    bool isHighPriority = model.isHighPriority;

    return showModalBottomSheet<bool>(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (context, setState) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),

                child: Form(
                  key: formKeytask,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //  SizedBox(height: 30),
                      CustomTextFormFields(
                        title: 'Task Name',
                        validator:
                            (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Please enter your  Task Name'
                                    : null,
                        hintText: 'Finish UI design for login screen',

                        controller: taskNameController,
                      ),

                      CustomTextFormFields(
                        title: 'Task Description',
                        maxLines: 5,
                        hintText:
                            'Finish onboarding UI and hand off to devs by Thursday.',
                        controller: taskDescriptionController,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'High Priority  ',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          Switch(
                            value: isHighPriority,
                            onChanged: (value) {
                              setState(() {
                                log(value.toString());
                                isHighPriority = value;
                              });
                            },
                          ),
                        ],
                      ),

                      Spacer(),
                      CustomElevatedButton(
                        label: Text(
                          'Edit Task',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        onPressed: () async {
                          //validate field
                          if (formKeytask.currentState?.validate() ?? false) {
                            final taskjson = PreferencesManager().getString(
                              'tasks',
                            );
                            List<dynamic> listtasks =
                                []; //List<Map<String, dynamic<>>
                            if (taskjson != null) {
                              //converted to list
                              listtasks = jsonDecode(taskjson);
                            }
                            TaskModel newmodel = TaskModel(
                              id: model.id,

                              taskname: taskNameController.text,
                              taskdescription: taskDescriptionController.text,
                              isHighPriority: isHighPriority,
                              isDone: model.isDone,
                            );

                            final items = listtasks.firstWhere(
                              (e) => e['id'] == model.id,
                            );
                            final int index = listtasks.indexOf(items);
                            listtasks[index] = newmodel;

                            final taskencode = jsonEncode(listtasks);

                            await PreferencesManager().setString(
                              'tasks',
                              taskencode,
                            );

                            Navigator.of(context).pop(true);
                          }
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),
        );
      },
    );
  }
}
