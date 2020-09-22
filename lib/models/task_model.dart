import 'package:flutter/material.dart';
import 'package:Taskist/task_priority.dart';

class TaskModel {
  String time = "";
  String taskName = "";
  String description = "";
  String notes = "";
  List<bool> repeats = [];
  TaskPriority priority = LowTaskPriority("");
  UniqueKey taskId = UniqueKey();
  TaskModel({
    this.time,
    this.taskName,
    this.repeats,
    this.priority,
    this.notes,
    this.description,
  });
}
