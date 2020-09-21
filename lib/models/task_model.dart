import 'dart:collection';

class TaskModel extends LinkedListEntry<TaskModel> {
  final String time;
  final String taskName;
  final List<bool> repeats;
  final int taskId = DateTime.now().microsecondsSinceEpoch;
  TaskModel({this.time, this.taskName, this.repeats});
}
