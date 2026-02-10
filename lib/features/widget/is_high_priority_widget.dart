import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_checkbox.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/features/controller/task_controller.dart';
import 'package:tasky/features/screens/high_priority_screen.dart';

class IsHighPriorityWidget extends StatelessWidget {
  const IsHighPriorityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(
      builder: (
        BuildContext context,
        TaskController controller,
        Widget? child,
      ) {
        final tasklist = controller.tasks;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16),
                      child: Text(
                        'High Priority Tasks',
                        style: TextStyle(
                          color: Color(0xff15B86C),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    ...tasklist
                        .where((e) => e.isHighPriority && e.isDone)
                        .take(4)
                        .map((element) {
                          return Row(
                            children: [
                              CustomCheckbox(
                                value: element.isDone,
                                onChanged: (bool? value) async {
                                  final index = tasklist.indexWhere(
                                    (e) => e.id == element.id,
                                  );
                                  controller.donehighPriorityTasks(
                                    value,
                                    index,
                                  );
                                },
                              ),

                              Expanded(
                                child: Text(
                                  element.taskName,
                                  style:
                                      element.isDone
                                          ? Theme.of(
                                            context,
                                          ).textTheme.titleLarge
                                          : Theme.of(
                                            context,
                                          ).textTheme.displaySmall,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HighPriorityScreen(),
                    ),
                  );
                  controller.init();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 56,
                    width: 48,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      border: Border.all(
                        color:
                            ThemeController.isDark()
                                ? Color(0xff6E6E6E)
                                : Color(0xffC6C6C6),
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CustomSvgPicture(
                      svgAssetPath: 'assets/svg/arrow-up-right.svg',
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
