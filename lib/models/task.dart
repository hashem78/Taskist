import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:Taskist/models/task_predicate.dart';

@immutable
class TaskModel extends Equatable {
  @override
  List<Object> get props => [
        time,
        taskName,
        taskId,
        description,
        notes,
        repeats,
        predicate,
        taskId,
      ];
  final String time;
  final String taskName;
  final String description;
  final String notes;
  final List<bool> repeats;
  final TaskPriorityPredicate predicate;
  final String taskId;
  TaskModel({
    this.time = "",
    this.taskName = "",
    this.repeats = const [],
    this.predicate,
    this.notes = "",
    this.description = "",
    this.taskId = "",
  });

  bool operator <(TaskModel other) {
    return this.predicate < other.predicate;
  }

  bool operator >(TaskModel other) {
    return other.predicate < this.predicate;
  }

  int get hashCode => int.tryParse(taskId);
  bool operator ==(Object other) {
    if (other is TaskModel) {
      return taskId == other.taskId;
    }
    return false;
  }

  @override
  bool get stringify => true;
}
