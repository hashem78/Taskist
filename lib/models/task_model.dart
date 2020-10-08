import 'package:Taskist/helpers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class TaskModel extends Equatable {
  final String taskId;
  final String taskName;
  final String description;
  final String notes;
  final List<bool> repeats;
  final TaskPriorityPredicate predicate;

  TaskModel({
    this.taskId = "",
    this.taskName = "",
    this.description = "",
    this.notes = "",
    this.repeats = const [],
    this.predicate = TaskPriorityPredicate.low,
  });

  @override
  List<Object> get props => [
        taskId,
        taskName,
        description,
        notes,
        repeats,
        predicate,
      ];
  Map<String, dynamic> toJson() {}
}
