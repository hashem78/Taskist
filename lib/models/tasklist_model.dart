import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  LinkedHashMap<String, TaskModel> tasks = LinkedHashMap();
  bool syncWithOnline = false;
  TaskListModel._();

  static Future<TaskListModel> loadLocalTasks() async {
    var listModel = TaskListModel._();

    var dir = await getApplicationDocumentsDirectory();
    File store = File(join(dir.path, "database.json"));
    if (!store.existsSync()) {
      await store.writeAsString("{}");
    }

    Map<String, dynamic> decoded = await json.decode(store.readAsStringSync());
    listModel.tasks.clear();
    decoded.forEach((key, value) {
      listModel.tasks[key] = TaskModel.fromJson(value);
    });

    return listModel;
  }

  Future<void> getOnlineTasks() async {
    tasks.clear();
    var collection = await FirebaseFirestore.instance.collection('tasks').get();
    var docs = collection.docs.map(
      (e) => TaskModel.fromJson(e.data()),
    );
    docs.forEach((element) {
      addTask(element);
    });
  }

  void addAll(List<TaskModel> list) {
    list.forEach((element) {
      tasks[element.taskId] = element;
    });
    notifyListeners();
    saveTasks();
  }

  Future<void> saveTasks() async {
    Map<String, dynamic> tmp = Map();
    tasks.forEach((key, value) => tmp[key] = value);

    var encoded = json.encode(tmp);
    var dir = await getApplicationDocumentsDirectory();
    File store = File(join(dir.path, "database.json"));
    await store.writeAsString(encoded, mode: FileMode.write);
  }

  void addTask(TaskModel newTask, {bool notify = false}) {
    if (!tasks.containsKey(newTask.taskId)) {
      tasks[newTask.taskId] = newTask;
      saveTasks();
      if (notify) notifyListeners();
    }
  }

  void rebuild() {
    notifyListeners();
  }

  bool contains(String id) {
    for (var task in tasks.values) if (task.taskId == id) return true;
    return false;
  }

  void removeTask(String id, {bool notify = false}) {
    tasks.remove(id);
    FirebaseFirestore.instance.collection('tasks').doc(id).delete();
    if (notify) notifyListeners();
    saveTasks();
  }
}
