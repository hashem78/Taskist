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
  GlobalKey<AnimatedListState> animatedListKey = GlobalKey();

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
    clear();
    var collection = await FirebaseFirestore.instance.collection('tasks').get();
    var docs = collection.docs.map(
      (e) => TaskModel.fromJson(e.data()),
    );
    docs.forEach((element) {
      addTask(element);
    });
  }

  Future<void> saveTasks() async {
    Map<String, dynamic> tmp = Map();
    tasks.forEach((key, value) => tmp[key] = value);

    var encoded = json.encode(tmp);
    var dir = await getApplicationDocumentsDirectory();
    File store = File(join(dir.path, "database.json"));
    await store.writeAsString(encoded, mode: FileMode.write);
  }

  void addTask(TaskModel newTask) {
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(newTask.taskId)
        .set(newTask.toJson());

    if (!tasks.containsKey(newTask.taskId)) {
      tasks[newTask.taskId] = newTask;
      animatedListKey.currentState.insertItem(
        tasks.length - 1,
        duration: Duration(milliseconds: 300 + 200 * tasks.length),
      );
      saveTasks();
      notifyListeners();
    }
  }

  bool contains(String id) {
    for (var task in tasks.values) if (task.taskId == id) return true;
    return false;
  }

  void clear() async {
    tasks.clear();
    animatedListKey = GlobalKey();
    notifyListeners();
  }

  void removeTask(String id) async {
    tasks.remove(id);
    animatedListKey = GlobalKey();
    notifyListeners();
    await saveTasks();
  }
}
