import 'package:flutter/material.dart';
import 'dart:collection';
import 'task_model.dart';

class TaskListModel extends ChangeNotifier {
  HashMap<UniqueKey, TaskModel> tasks = HashMap<UniqueKey, TaskModel>();

  void addTask(TaskModel newTask) {
    tasks[newTask.taskId] = newTask;
    notifyListeners();
  }

  bool contains(UniqueKey id) {
    if (tasks.containsKey(id)) return true;
    return false;
  }

  bool removeTask(UniqueKey id) {
    if (contains(id)) {
      tasks.remove(id);
      notifyListeners();
      return true;
    }
    return false;
  }
}
