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
    return Dismissible(
      key: Key(model.taskId),
      onDismissed: (_) {
        Provider.of<TaskListModel>(context, listen: false)
            .removeTask(model.taskId);
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          const Radius.circular(50),
        ),
        child: Material(
          color: model.priority.color,
          child: InkWell(
            onTap: () {
              showBottomSheet(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
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
                  padding: const EdgeInsets.all(15.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text(
                      model.taskName[0].toUpperCase(),
                      style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    radius: 30,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      model.taskName,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
