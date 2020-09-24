import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';
import 'package:Taskist/models/task_model.dart';
import 'package:Taskist/widgets/taskday_button.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({
    Key key,
    @required this.model,
  }) : super(key: key);

  final TaskModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Wrap(
        children: [
          Center(
            child: Text(
              model.taskName,
              style: TextStyle(
                fontSize: 60,
                color: kTextColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model.description,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 25, color: kTextColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 7; ++i)
                TaskDayButton.noModel(
                  title: kdayTitles[i],
                  isActive: model.repeats[i],
                ),
            ],
          )
        ],
      ),
    );
  }
}
