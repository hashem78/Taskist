import 'dart:collection';

import 'package:Taskist/models/task.dart';

import 'package:flutter/foundation.dart';

import '../models/task_predicate.dart';

@immutable
abstract class TasksRepository {
  Future<void> add(TaskModel model);

  Future<void> remove(String id);

  List<TaskModel> tasksFromRawData(List<Map<String, dynamic>> rawData) {
    var _internalList = <TaskModel>[];

    rawData.forEach((element) => _internalList.add(jsonToTask(element)));
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

  TaskModel jsonToTask(Map<String, dynamic> rawModel) => TaskModel(
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

  Map<String, dynamic> tasktoJson(TaskModel taskModel) => {
        'time': taskModel.time,
        'taskName': taskModel.taskName,
        'description': taskModel.description,
        'notes': taskModel.notes,
        'repeats': taskModel.repeats,
        'taskId': taskModel.taskId,
        'predicate': taskModel.predicate.toString()
      };
}
