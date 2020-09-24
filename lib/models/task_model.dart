import 'package:flutter/material.dart';
import 'package:Taskist/task_priority.dart';

class TaskModel {
  String time = "";
  String taskName = "";
  String description = "";
  String notes = "";
  List<bool> repeats = [];
  TaskPriority priority = LowTaskPriority("");
  String taskId = UniqueKey().toString();
  TaskModel({
    this.time,
    this.taskName,
    this.repeats,
    this.priority,
    this.notes,
    this.description,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        taskName = json['taskName'],
        description = json['description'],
        notes = json['notes'],
        repeats = List<bool>.from(json['repeats']),
        priority = json['priority'] == "high"
            ? HighTaskPriority("")
            : json['priority'] == 'medium'
                ? MediumTaskPriority("")
                : LowTaskPriority(""),
        taskId = json['taskId'];
  Map<String, dynamic> toJson() => {
        'time': time,
        'taskName': taskName,
        'description': description,
        'notes': notes,
        'repeats': repeats,
        'taskId': taskId,
        'priority': priority.toString()
      };
}
