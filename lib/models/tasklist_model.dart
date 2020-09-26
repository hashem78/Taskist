import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

int tasksCompareDescending(TaskModel a, TaskModel b) {
  if (a < b)
    return 1;
  else
    return -1;
}

int tasksCompareAscending(TaskModel a, TaskModel b) {
  if (a < b)
    return -1;
  else
    return 1;
}

class TaskListModel extends ChangeNotifier {
  List<TaskModel> tasks = [];
  TaskListModel(this.tasks);

  static Future<List<TaskModel>> load() async {
    List<TaskModel> tasks = [];
    var dir = await getApplicationDocumentsDirectory();
    File store = File(join(dir.path, "database.json"));
    if (store.existsSync()) {
      print("file exists");
    } else {
      await store.writeAsString("[]");
    }
    print("located ${store.path}");
    try {
      List<dynamic> decoded = json.decode(store.readAsStringSync());
      print("decoded store file");
      print("decoded is not empty");
      for (var value in decoded) {
        tasks.add(TaskModel.fromJson(value));
      }
    } catch (e) {
      print(e.toString());
    }

    return tasks;
  }

  Future<void> saveTasks() async {
    var encoded = json.encode(tasks);
    var dir = await getApplicationDocumentsDirectory();
    File store = File(join(dir.path, "database.json"));
    await store.writeAsString(encoded, mode: FileMode.write);
  }

  void addTask(TaskModel newTask) async {
    tasks.add(newTask);
    notifyListeners();
    await saveTasks();
  }

  bool contains(String id) {
    for (var task in tasks) if (task.taskId == id) return true;
    return false;
  }

  void remove(String id) {
    for (var task in tasks)
      if (task.taskId == id) {
        tasks.remove(task);
        return;
      }
  }

  bool removeTask(String id) {
    if (contains(id)) {
      remove(id);
      notifyListeners();
      saveTasks();
      return true;
    }
    return false;
  }

  // order = false -> descending
  // order = true -> ascending
  void sortBasedOnPriority({bool order = false}) {
    if (!order)
      tasks.sort(tasksCompareDescending);
    else
      tasks.sort(tasksCompareAscending);
    notifyListeners();
  }
}
