import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
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

  TaskModel copyWith({
    String? id,
    String? taskname,
    String? taskdescription,
    bool? isDone,
    bool? isHighPriority,
  }) {
    return TaskModel(
      id: id ?? this.id,
      taskname: taskname ?? this.taskname,
      taskdescription: taskdescription ?? this.taskdescription,
      isDone: isDone ?? this.isDone,
      isHighPriority: isHighPriority ?? this.isHighPriority,
    );
  }

  @override
  List<Object?> get props => [
    id,
    taskname,
    taskdescription,
    isHighPriority,
    isDone,
  ];

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
  String toString() {
    return 'TaskModel{id: $id, taskName: $taskname, taskDescription: $taskdescription, isHighPriority: $isHighPriority, isDone: $isDone}';
  }
}
