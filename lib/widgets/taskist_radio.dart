import 'package:Taskist/models/task_predicate.dart';
import 'package:flutter/material.dart';

class TaskistRadio extends StatelessWidget {
  final TaskPriorityPredicate taskPriority;
  final TaskPriorityPredicate groupValue;
  final String title;
  final Function(TaskPriorityPredicate) onChanged;
  TaskistRadio({
    @required this.taskPriority,
    @required this.title,
    @required this.onChanged,
    @required this.groupValue,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Radio<TaskPriorityPredicate>(
          activeColor: taskPriority.color,
          value: taskPriority,
          groupValue: groupValue,
          onChanged: (val) => onChanged(val),
        ),
        Text(
          title,
          style: TextStyle(
            color: taskPriority.color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
