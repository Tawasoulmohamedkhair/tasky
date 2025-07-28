import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String id;
  final String taskname;
  final String taskdescription;
  final bool isHighPriority;
  bool isDone;

  TaskModel({
    required this.id,
    required this.taskname,
    required this.taskdescription,
    required this.isHighPriority,
    this.isDone = false,
  });

  @override
  List<Object?> get props => [taskname, taskdescription, isHighPriority];
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'].toString(),
      taskname: json['taskname'] ?? '',
      taskdescription: json['taskdescription'] ?? '',
      isHighPriority: json['isHighPriority'] ?? false,
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "taskname": taskname,
      "taskdescription": taskdescription,
      "isHighPriority": isHighPriority,
      "isDone": isDone,
    };
  }

  @override
  String toString() => taskname;
}
