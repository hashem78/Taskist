import 'dart:collection';

import 'package:flutter/material.dart';

class TaskModel extends LinkedListEntry<TaskModel> {
  final String time;
  final String taskName;
  final List<bool> repeats;
  final UniqueKey taskId = UniqueKey();
  TaskModel({this.time, this.taskName, this.repeats});
}
