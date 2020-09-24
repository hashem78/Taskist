import 'package:Taskist/models/taskpriority_model.dart';
import 'package:flutter/material.dart';

class RadioPriorityRowModel with ChangeNotifier {
  TaskPriority priority;
  void changePriority(TaskPriority newPriority) {
    priority = newPriority;
    notifyListeners();
  }
}
