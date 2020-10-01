import 'package:Taskist/models/task_model.dart';
import 'package:Taskist/models/tasklist_model.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';
import 'package:Taskist/screens/taskdetails_screen.dart';
import 'package:provider/provider.dart';

class TaskTile extends StatelessWidget {
  final TaskModel model;

  TaskTile({this.model});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Dismissible(
        key: Key(model.taskId),
        onDismissed: (_) =>
            context.read<TaskListModel>().removeTask(model.taskId),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              const Radius.circular(60),
            ),
            child: Material(
              color: model.predicate.color,
              child: InkWell(
                onTap: () {
                  showBottomSheet(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.only(
                        topLeft: const Radius.circular(50),
                        topRight: const Radius.circular(50),
                      ),
                    ),
                    context: (context),
                    builder: (context) => TaskDetailsScreen(model: model),
                  );
                },
                splashColor: Colors.grey,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(
                          model.taskName[0].toUpperCase(),
                          style: const TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        radius: 30,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        model.taskName,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
