import 'package:flutter/material.dart';
import 'dart:collection';
import 'task_model.dart';

class TaskListModel extends ChangeNotifier {
  LinkedList<TaskModel> tasks = LinkedList<TaskModel>();

  void addTask(TaskModel newTask) {
    tasks.add(newTask);
    notifyListeners();
  }

  bool contains(UniqueKey id) {
    for (var item in tasks) {
      if (item.taskId == id) return true;
    }
    return false;
  }

  bool removeTask(UniqueKey id) {
    if (contains(id)) {
      for (var item in tasks) {
        if (item.taskId == id) {
          tasks.remove(item);
          break;
        }
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  bool changePlace(TaskModel task, TaskModel other, bool flag) {
    // if flag is true insert before if flag is false insert after
    try {
      task.unlink();
      flag ? task.insertBefore(other) : task.insertAfter(other);
      return true;
    } catch (e) {
      print("Oopsie doopsy! $e");
      return false;
    }
  }
}
