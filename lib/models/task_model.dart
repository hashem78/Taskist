import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:Taskist/task_priority.dart';

class TaskModel extends LinkedListEntry<TaskModel> {
  final String time;
  final String taskName;
  final List<bool> repeats;
  final TaskPriority priority;
  final UniqueKey taskId = UniqueKey();
  TaskModel({this.time, this.taskName, this.repeats, this.priority});
}
