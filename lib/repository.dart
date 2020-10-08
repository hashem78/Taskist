import 'dart:collection';

import 'package:Taskist/data_providers/local_data_provider.dart';
import 'package:Taskist/models/task_model.dart';
import 'package:Taskist/data_providers/online_data_provider.dart';
import 'package:flutter/foundation.dart';

import 'models/task_predicate_model.dart';

@immutable
class Repository {
  final OnlineDataProvider onlineDataProvider;
  final LocalDataProvider localDataProvider;
  Repository._(String collectionPath, String path)
      : onlineDataProvider = OnlineDataProvider('tasks'),
        localDataProvider = LocalDataProvider('localData');
  factory Repository.init(String collectionPath, String path) {
    var repo = Repository._(collectionPath, path);
    repo.localDataProvider.init();
    return repo;
  }
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

  List<TaskModel> _tasksFromRawData(List<Map<String, dynamic>> rawData) {
    var _internalList = <TaskModel>[];
    rawData.forEach(
      (element) {
        _internalList.add(_jsonToTask(element));
      },
    );
    return UnmodifiableListView(_internalList);
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

  TaskModel _jsonToTask(Map<String, dynamic> rawModel) => TaskModel(
        taskId: rawModel['taskId'],
        taskName: rawModel['taskName'],
        description: rawModel['description'],
        time: rawModel['time'],
        notes: rawModel['notes'],
        repeats: List<bool>.from(rawModel['repeats']),
        predicate: rawModel['predicate'] == "high"
            ? HighTaskPriorityPredicate()
            : rawModel['predicate'] == 'medium'
                ? MediumTaskPriorityPredicate()
                : rawModel['predicate'] == 'low'
                    ? LowTaskPriorityPredicate()
                    : NoPriorityPredicate(),
      );

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
