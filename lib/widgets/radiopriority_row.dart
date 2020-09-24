import 'package:Taskist/constants.dart';
import 'package:Taskist/task_priority.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Taskist/models/radiopriority_model.dart';

class RadioPriorityRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Column(
        children: [
          const Text(
            "Priority",
            style: TextStyle(
              color: kTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TaskistRadio(
                HighTaskPriority(""),
                "High",
              ),
              TaskistRadio(
                MediumTaskPriority(""),
                "Medium",
              ),
              TaskistRadio(
                LowTaskPriority(""),
                "Low",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TaskistRadio extends StatelessWidget {
  final TaskPriority taskPriority;
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
