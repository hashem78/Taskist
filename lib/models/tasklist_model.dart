import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class TaskListModel extends ChangeNotifier {
  Map<String, TaskModel> tasks;

  TaskListModel(this.tasks);

  static Future<Map<String, TaskModel>> load() async {
    Map<String, TaskModel> tasks = {};
    var dir = await getApplicationDocumentsDirectory();
    File store = File(join(dir.path, "database.json"));
    if (store.existsSync()) {
      print("file exists");
    } else {
      await store.writeAsString("{}");
    }
    print("located ${store.path}");
    try {
      Map<String, dynamic> decoded = json.decode(store.readAsStringSync());
      print("decoded store file");
      print("decoded is not empty");
      for (var value in decoded.entries) {
        tasks[value.key] = TaskModel.fromJson(value.value);
      }
      print("done for looping");
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
    print("saved tasks");
  }

  void addTask(TaskModel newTask) async {
    tasks[newTask.taskId] = newTask;
    notifyListeners();
    await saveTasks();
  }

  bool contains(String id) {
    if (tasks.containsKey(id)) return true;
    return false;
  }

  bool removeTask(String id) {
    if (contains(id)) {
      print("removed $id");
      tasks.remove(id);
      notifyListeners();
      saveTasks();
      return true;
    }
    return false;
  }
}
