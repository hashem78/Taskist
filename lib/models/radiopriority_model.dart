import 'package:Taskist/task_priority.dart';
import 'package:flutter/material.dart';

class RadioPriorityRowModel with ChangeNotifier {
  TaskPriority priority;
  void changePriority(TaskPriority newPriority) {
    priority = newPriority;
    notifyListeners();
  }
}
