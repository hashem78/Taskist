import 'package:Taskist/models/radiopriority_model.dart';
import 'package:Taskist/widgets/radiopriority_row.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/widgets/taskity_texfield.dart';
import 'package:Taskist/models/tasklist_model.dart';
import 'package:Taskist/models/task_model.dart';
import 'package:Taskist/constants.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatelessWidget {
  final List<TaskityTextField> fieldList = [
    TaskityTextField(
      title: "Name",
      hintText: "Feed the cats!",
    ),
    TaskityTextField(
      title: "Description",
      hintText: "Describe me bby!",
    ),
    TaskityTextField(
      title: "Notes",
      hintText: "Not the salamon",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.5,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              padding: EdgeInsets.all(30),
              child: Text(
                "New Task",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: kTextColor,
                ),
              ),
            ),
            for (var item in fieldList) item,
            RadioPriorityRow(),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              color: kprimaryDarkColor,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Add Task",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 20,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () {
                context.read<TaskListModel>().addTask(
                      TaskModel(
                        taskName: fieldList[0].controller.text,
                        time: fieldList[1].controller.text,
                        priority: Provider.of<RadioPriorityRowModel>(
                          context,
                          listen: false,
                        ).priority,
                        repeats: [],
                      ),
                    );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
