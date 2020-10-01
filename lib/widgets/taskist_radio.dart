import 'package:flutter/material.dart';
import 'package:Taskist/models/radiopriority_model.dart';
import 'package:Taskist/models/taskpriority_model.dart';
import 'package:provider/provider.dart';

class TaskistRadio extends StatelessWidget {
  final TaskPriorityPredicate taskPriority;
  final String title;
  TaskistRadio(this.taskPriority, this.title);
  @override
  Widget build(BuildContext context) {
    return Consumer<RadioPriorityRowModel>(
      builder: (_, newPriority, __) => Column(
        children: [
          Radio(
            activeColor: taskPriority.color,
            value: taskPriority,
            groupValue: newPriority.priority,
            onChanged: (val) => newPriority.changePriority(val),
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
      ),
    );
  }
}
