import 'dart:collection';

import 'package:Taskist/data_providers/local_data.dart';
import 'package:Taskist/models/task.dart';
import 'package:Taskist/models/task_predicate.dart';
import 'package:Taskist/repositories/repository.dart';

class LocalTasksRepository extends TasksRepository {
  final LocalDataProvider localDataProvider;

  LocalTasksRepository(String path)
      : localDataProvider = LocalDataProvider(path);

  Future<List<TaskModel>> fetch() async {
    var _internalList = await localDataProvider.fetch();
    var _listOfData = tasksFromRawData(_internalList);
    return UnmodifiableListView(_listOfData);
  }

  Future<List<TaskModel>> filter(TaskPriorityPredicate predicate) async {
    var _internalList = await localDataProvider.fetchWithPredicate(predicate);
    var _listOfData = tasksFromRawData(_internalList);
    return UnmodifiableListView(_listOfData);
  }

  Future<void> add(TaskModel model) async =>
      await localDataProvider.add(tasktoJson(model));

  Future<void> remove(String id) async => await localDataProvider.remove(id);

  Future<void> removeLocal(String id) async =>
      await localDataProvider.remove(id);
}
