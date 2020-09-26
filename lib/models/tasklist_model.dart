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
  List<TaskModel> tasks = [];
  bool syncWithOnline = false;
  TaskListModel(this.tasks);

  void triggerSync() async {
    if (syncWithOnline == false) {
      syncWithOnline = true;
      var collection =
          await FirebaseFirestore.instance.collection('tasks').get();
      //get the local models to the server first
      for (var model in tasks) {
        var alreadyInFirestore = (await FirebaseFirestore.instance
                .collection('tasks')
                .doc(model.taskId)
                .get())
            .exists;

        if (!alreadyInFirestore) {
          print("not found in firestore but in local");
          print(model.taskId);
          await FirebaseFirestore.instance
              .collection('tasks')
              .doc(model.taskId)
              .set(
                model.toJson(),
                SetOptions(merge: true),
              );
        }
      }
      collection = await FirebaseFirestore.instance.collection('tasks').get();
      tasks.clear();
      for (var model in collection.docs) {
        var tmodel = TaskModel.fromJson(model.data());
        tasks.add(tmodel);
      }
    } else {
      syncWithOnline = false;
    }
    notifyListeners();
  }

  static Future<List<TaskModel>> load() async {
    List<TaskModel> tasks = [];
    var dir = await getApplicationDocumentsDirectory();
    File store = File(join(dir.path, "database.json"));
    if (store.existsSync()) {
    } else {
      await store.writeAsString("[]");
    }
    try {
      List<dynamic> decoded = json.decode(store.readAsStringSync());
      for (var value in decoded) {
        tasks.add(TaskModel.fromJson(value));
      }
    } catch (e) {}
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
    print("added to local");
    notifyListeners();
    await saveTasks();
    if (syncWithOnline) {
      print("added to firestore");
      FirebaseFirestore.instance.collection('tasks').doc(newTask.taskId).set(
            newTask.toJson(),
            SetOptions(merge: true),
          );
    }
  }

  bool contains(String id) {
    for (var task in tasks) if (task.taskId == id) return true;
    return false;
  }

  Future<void> remove(String id) async {
    for (var task in tasks)
      if (task.taskId == id) {
        tasks.remove(task);
        break;
      }
    if (syncWithOnline) {
      try {
        bool v =
            (await FirebaseFirestore.instance.collection('tasks').doc(id).get())
                .exists;
        print("it $v exist");
        await FirebaseFirestore.instance.collection('tasks').doc(id).delete();
      } catch (e) {}
    }
  }

  Future<void> removeTask(String id) async {
    await remove(id);
    notifyListeners();
    await saveTasks();
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
