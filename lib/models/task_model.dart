import 'package:Taskist/models/taskpriority_model.dart';

class TaskModel {
  String time = "";
  String taskName = "";
  String description = "";
  String notes = "";
  List<bool> repeats = [];
  TaskPriority priority = LowTaskPriority("");
  String taskId;
  TaskModel({
    this.time,
    this.taskName,
    this.repeats,
    this.priority,
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
        priority = json['priority'] == "high"
            ? HighTaskPriority("")
            : json['priority'] == 'medium'
                ? MediumTaskPriority("")
                : LowTaskPriority(""),
        taskId = json['taskId'];
  Map<String, dynamic> toJson() => {
        'time': time,
        'taskName': taskName,
        'description': description,
        'notes': notes,
        'repeats': repeats,
        'taskId': taskId,
        'priority': priority.toString()
      };
  bool operator <(TaskModel other) {
    return this.priority < other.priority;
  }

  bool operator >(TaskModel other) {
    return other.priority < this.priority;
  }

  int get hashCode => int.tryParse(taskId);
  bool operator ==(Object other) {
    if (other is TaskModel) {
      return taskId == other.taskId;
    }
    return false;
  }
}
