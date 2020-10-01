import 'package:Taskist/models/taskpriority_model.dart';
import 'package:flutter/material.dart';

class RadioPriorityRowModel with ChangeNotifier {
  TaskPriorityPredicate priority;
  void changePriority(TaskPriorityPredicate newPriority) {
    priority = newPriority;
    notifyListeners();
  }
}
