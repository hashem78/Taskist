import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:Taskist/models/task_predicate.dart';

class TaskFormModel extends Equatable {
  final TaskPriorityPredicate priorityPredicate;
  final List<bool> repeats;
  TaskFormModel({
    @required this.priorityPredicate,
    @required this.repeats,
  });
  @override
  List<Object> get props => [
        priorityPredicate,
        repeats,
      ];

  @override
  bool get stringify => true;

  TaskFormModel copyWith({
    TaskPriorityPredicate priorityPredicate,
    List<bool> repeats,
  }) {
    return TaskFormModel(
      priorityPredicate: priorityPredicate ?? this.priorityPredicate,
      repeats: repeats ?? this.repeats,
    );
  }
}
