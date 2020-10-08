import 'dart:collection';

import 'package:Taskist/data_providers/local_data_provider.dart';
import 'package:Taskist/models/task_model.dart';
import 'package:Taskist/data_providers/online_data_provider.dart';
import 'package:flutter/foundation.dart';

import 'models/task_predicate_model.dart';

@immutable
class TasksRepository {
  final OnlineDataProvider onlineDataProvider;
  final LocalDataProvider localDataProvider;

  TasksRepository(String collectionPath, String path)
      : onlineDataProvider = OnlineDataProvider(collectionPath),
        localDataProvider = LocalDataProvider(path);

  Future<List<TaskModel>> fetchOnline() async {
    var _internalList = await onlineDataProvider.fetch();
    var _listOfData = _tasksFromRawData(_internalList);
    return UnmodifiableListView(_listOfData);
  }

  Future<List<TaskModel>> fetchLocal() async {
    var _internalList = await localDataProvider.fetch();
    var _listOfData = _tasksFromRawData(_internalList);
    return UnmodifiableListView(_listOfData);
  }

  Future<List<TaskModel>> fetchAll() async {
    var _localList = await fetchLocal();
    var _onlineList = await fetchOnline();
    return UnmodifiableListView(
      [
        ..._localList,
        ..._onlineList,
      ],
    );
  }

  Future<void> add(TaskModel model) async {
    var raw = _tasktoJson(model);
    //await onlineDataProvider.add(raw);
    await localDataProvider.add(raw);
  }

  Future<void> remove(String id) async {
    await onlineDataProvider.remove(id);
    await localDataProvider.remove(id);
  }

  Future<void> removeOnline(String id) async {
    await onlineDataProvider.remove(id);
  }

  Future<void> removeLocal(String id) async {
    await localDataProvider.remove(id);
  }

  List<TaskModel> _tasksFromRawData(List<Map<String, dynamic>> rawData) {
    var _internalList = <TaskModel>[];

    rawData.forEach((element) => _internalList.add(_jsonToTask(element)));
    return _internalList;
  }

  List<TaskModel> filter(
      List<TaskModel> taskList, TaskPriorityPredicate predicate) {
    var _internalList = <TaskModel>[];
    taskList.forEach(
      (element) {
        if (element.predicate == predicate) {
          _internalList.add(element);
        }
      },
    );
    return UnmodifiableListView(_internalList);
  }

  TaskModel _jsonToTask(Map<String, dynamic> rawModel) {
    final model = TaskModel(
      taskId: rawModel['taskId'],
      taskName: rawModel['taskName'],
      description: rawModel['description'],
      time: rawModel['time'],
      notes: rawModel['notes'],
      repeats: [false, false, false, false, false, false, false],
      predicate: rawModel['predicate'] == "high"
          ? HighTaskPriorityPredicate()
          : rawModel['predicate'] == 'medium'
              ? MediumTaskPriorityPredicate()
              : rawModel['predicate'] == 'low'
                  ? LowTaskPriorityPredicate()
                  : NoPriorityPredicate(),
    );
    return model;
  }

  // ignore: unused_element
  Map<String, dynamic> _tasktoJson(TaskModel taskModel) => {
        'time': taskModel.time,
        'taskName': taskModel.taskName,
        'description': taskModel.description,
        'notes': taskModel.notes,
        'repeats': taskModel.repeats,
        'taskId': taskModel.taskId,
        'predicate': taskModel.predicate.toString()
      };
}
