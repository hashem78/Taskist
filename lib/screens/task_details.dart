import 'package:Taskist/models/task.dart';
import 'package:Taskist/widgets/task_day_button.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';

const _noNotes = "There are no notes on this task";
const _noDescription = "There is no description for this task";

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({
    Key key,
    @required this.model,
  }) : super(key: key);

  final TaskModel model;

  @override
  Widget build(BuildContext context) {
    print("${model.toString()}");
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Wrap(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "${model.taskName}\n",
                    style: TextStyle(color: Colors.greenAccent, fontSize: 60),
                  ),
                  TextSpan(
                    text: "Description\n",
                    style: TextStyle(fontSize: 40, color: kTextColor),
                  ),
                  TextSpan(
                    text:
                        "     ${model.description.isEmpty ? _noDescription : model.description}\n",
                    style: TextStyle(
                      fontSize: 25,
                      color:
                          model.description.isEmpty ? Colors.red : Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "Notes\n",
                    style: TextStyle(fontSize: 40, color: kTextColor),
                  ),
                  TextSpan(
                    text:
                        "     ${model.notes.isEmpty ? _noNotes : model.notes}\n",
                    style: TextStyle(
                      fontSize: 25,
                      color: model.notes.isEmpty ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 7; ++i)
                  TaskDayButton.ignore(
                    title: kdayTitles[i],
                    isActive: model.repeats[i],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
