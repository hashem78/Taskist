import 'package:Taskist/models/taskpriority_model.dart';

class TaskModel {
  String time = "";
  String taskName = "";
  String description = "";
  String notes = "";
  List<bool> repeats = [];
  TaskPriorityPredicate predicate = LowTaskPriorityPredicate();
  String taskId;
  TaskModel({
    this.time,
    this.taskName,
    this.repeats,
    this.predicate,
    this.notes,
    this.description,
    this.taskId,
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
