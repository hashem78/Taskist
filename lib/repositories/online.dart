import 'dart:collection';

import 'package:Taskist/models/task.dart';
import 'package:Taskist/data_providers/online_data.dart';
import 'package:Taskist/models/task_predicate.dart';
import 'package:Taskist/repositories/repository.dart';
import 'package:flutter/foundation.dart';

@immutable
class OnlineTasksRepository extends TasksRepository {
  final OnlineDataProvider onlineDataProvider;

  OnlineTasksRepository(String path)
      : onlineDataProvider = OnlineDataProvider(path);

  Future<List<TaskModel>> fetch() async {
    var _internalList = await onlineDataProvider.fetch();
    var _listOfData = tasksFromRawData(_internalList);
    return UnmodifiableListView(_listOfData);
  }

  Future<List<TaskModel>> filter(TaskPriorityPredicate predicate) async {
    var _internalList = await onlineDataProvider.fetchWithPredicate(predicate);
    var _listOfData = tasksFromRawData(_internalList);
    return UnmodifiableListView(_listOfData);
  }

  Future<void> add(TaskModel model) async =>
      await onlineDataProvider.add(tasktoJson(model));

  Future<void> remove(String id) async => await onlineDataProvider.remove(id);
}
