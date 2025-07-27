// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_elevated_button.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/data/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTaskScreen> {
  final GlobalKey<FormState> _formKeytask = GlobalKey<FormState>();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();
  bool isHighPriority = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Task',
          // style: Theme.of(context).textTheme.titleMedium
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        child: Form(
          key: _formKeytask,
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

                controller: taskNameController,
              ),

              SizedBox(height: 20),

              CustomTextFormFields(
                title: 'Task Description',
                maxLines: 5,
                hintText:
                    'Finish onboarding UI and hand off to devs by Thursday.',
                controller: taskDescriptionController,
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'High Priority  ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFFFCFC),
                    ),
                  ),
                  Switch(
                    //activeTrackColor: Color(0xff15B86C),
                    value: isHighPriority,
                    onChanged: (value) {
                      setState(() {
                        isHighPriority = value;
                      });
                    },
                  ),
                ],
              ),
              Spacer(),
              CustomElevatedButton(
                onPressed: () async {
                  //validate field
                  if (_formKeytask.currentState?.validate() ?? false) {
                    //save data
                    //check by key=>'tasks'->String
                    final taskjson = PreferencesManager().getString('tasks');
                    // initialize list of dynami
                    List<dynamic> listtasks = []; //List<Map<String, dynamic<>>
                    //it is not empty
                    if (taskjson != null) {
                      //converted to list
                      listtasks = jsonDecode(taskjson);
                    }
                    final random = Random();

                    //listtasks.length =1=>1+1
                    TaskModel model = TaskModel(
                      id: random.nextInt(1000), // Generate a random ID
                      taskname: taskNameController.text,
                      taskdescription: taskDescriptionController.text,
                      isHighPriority: isHighPriority,
                    );
                    //list of Map
                    listtasks.add(model.toJson());
                    //convert to String
                    final taskencode = jsonEncode(listtasks);

                    await PreferencesManager().setString('tasks', taskencode);

                    Navigator.of(context).pop(true);
                  }
                  _formKeytask.currentState!.validate();
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
  }
}
