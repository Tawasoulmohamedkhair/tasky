// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/widgets/custom_elevated_button.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/features/controller/addtask/add_task_controller.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (context) => AddTaskController(),
      builder: (context, child) {
        final controller = context.read<AddTaskController>();

        return Scaffold(
          appBar: AppBar(title: Text('New Task')),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            child: Form(
              key: controller.formKeytask,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormFields(
                    title: 'Task Name',
                    validator:
                        (value) =>
                            value == null || value.trim().isEmpty
                                ? 'Please enter your  Task Name'
                                : null,
                    hintText: 'Finish UI design for login screen',

                    controller: controller.taskNameController,
                  ),

                  SizedBox(height: 20),

                  CustomTextFormFields(
                    title: 'Task Description',
                    maxLines: 5,
                    hintText:
                        'Finish onboarding UI and hand off to devs by Thursday.',
                    controller: controller.taskDescriptionController,
                  ),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'High Priority  ',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Consumer(
                        builder:
                            (context, AddTaskController value, _) => Switch(
                              value: value.isHighPriority,
                              onChanged: (value) {
                                controller.toggle(value);
                              },
                            ),
                      ),
                    ],
                  ),
                  Spacer(),

                  CustomElevatedButton(
                    onPressed: () async {
                      context.read<AddTaskController>().addTask(context);
                    },
                    icon: Icon(Icons.add),
                    label: Text(
                      'Add Task',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
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
