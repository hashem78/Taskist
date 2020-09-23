import 'package:Taskist/models/task_model.dart';
import 'package:Taskist/widgets/taskday_button.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';

class TaskTile extends StatelessWidget {
  final TaskModel model;

  TaskTile({this.model});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
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
              builder: (context) => TaskDetails(model: model),
            );
          },
          splashColor: Colors.grey,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
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
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskDetails extends StatelessWidget {
  const TaskDetails({
    Key key,
    @required this.model,
  }) : super(key: key);

  final TaskModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.3,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              style: TextStyle(fontSize: 25, color: kTextColor),
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
