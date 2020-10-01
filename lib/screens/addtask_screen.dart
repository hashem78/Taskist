import 'package:Taskist/models/daybuttons_model.dart';
import 'package:Taskist/models/radiopriority_model.dart';
import 'package:Taskist/widgets/radiopriority_row.dart';
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
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Wrap(
          runSpacing: 6,
          alignment: WrapAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: const BorderRadius.all(
                  const Radius.circular(100),
                ),
              ),
              padding: const EdgeInsets.all(30),
              child: const Text(
                "New Task",
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: kTextColor,
                ),
              ),
            ),
            for (var item in kfieldList) item,
            RadioPriorityRow(),
            Column(
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kprimaryDarkColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Add Task",
                  style: const TextStyle(
                    color: kTextColor,
                    fontSize: 20,
                  ),
                ),
              ),
              onPressed: () {
                buildTaskModel(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
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
        );
  }
}
