import 'package:Taskist/models/taskpriority_model.dart';
import 'package:equatable/equatable.dart';

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
  TaskModel.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        taskName = json['taskName'],
        description = json['description'],
        notes = json['notes'],
        repeats = List<bool>.from(json['repeats']),
        predicate = json['predicate'] == "high"
            ? HighTaskPriorityPredicate()
            : json['predicate'] == 'medium'
                ? MediumTaskPriorityPredicate()
                : json['predicate'] == 'low'
                    ? LowTaskPriorityPredicate()
                    : NoPriorityPredicate(),
        taskId = json['taskId'];
  Map<String, dynamic> toJson() => {
        'time': time,
        'taskName': taskName,
        'description': description,
        'notes': notes,
        'repeats': repeats,
        'taskId': taskId,
        'predicate': predicate.toString()
      };
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
}
