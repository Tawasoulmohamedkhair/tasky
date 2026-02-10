import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/controller/task_controller.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (
        BuildContext context,
        TaskController controller,
        Widget? child,
      ) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Achieved Tasks',

                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${controller.totalDoneTasks} Out of ${controller.totalTask} Done',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: -pi / 2,
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(
                        value: controller.percent,
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation(Color(0xff15B86C)),
                        backgroundColor: Color(0xff6D6D6D),
                      ),
                    ),
                  ),
                  Text(
                    '${((controller.percent * 100)).toInt()}%',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
