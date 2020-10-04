import 'package:Taskist/models/daybuttons_model.dart';
import 'package:Taskist/models/radiopriority_model.dart';
import 'package:Taskist/components/radiopriority_row.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/models/tasklist_model.dart';
import 'package:Taskist/models/task_model.dart';
import 'package:Taskist/constants.dart';
import 'package:provider/provider.dart';
import 'package:Taskist/widgets/taskday_button.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            const Text(
              "New Task",
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: kTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            for (var item in kfieldList) item,
            Container(
              child: RadioPriorityRow(),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              margin: EdgeInsets.only(bottom: 10, top: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: const Text(
                      "Repeat on",
                      style: const TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < 7; ++i)
                        TaskDayButton(
                          title: kdayTitles[i],
                          index: i,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: buildAddButton(context),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildAddButton(BuildContext context) {
    return ElevatedButton(
      focusNode: FocusNode(canRequestFocus: true),
      style: ElevatedButton.styleFrom(
        elevation: 3,
        primary: Colors.blue[600],
        minimumSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height / 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: const Text(
          "Add Task",
          style: const TextStyle(
            color: kTextColor,
            fontSize: 25,
          ),
        ),
      ),
      onPressed: kfieldList[0].controller.text.isEmpty
          ? null
          : () {
              buildTaskModel(context);
              Navigator.pop(context);
            },
    );
  }

  void buildTaskModel(BuildContext context) {
    // TODO: notification on time
    return context.read<TaskListModel>().addTask(
          TaskModel(
            taskName: kfieldList[0].controller.text,
            description: kfieldList[1].controller.text,
            notes: kfieldList[2].controller.text,
            predicate: Provider.of<RadioPriorityRowModel>(
              context,
              listen: false,
            ).priority,
            repeats: [...context.read<DayButtonsModel>().repeates],
            taskId: UniqueKey().toString().replaceAll(RegExp(r'(\[|\]|#)'), ''),
          ),
          notify: false,
        );
  }
}
