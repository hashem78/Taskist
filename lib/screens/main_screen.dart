import 'package:Taskist/constants.dart';
import 'package:Taskist/models/daybuttons_model.dart';
import 'package:Taskist/models/tasklist_model.dart';
import 'package:Taskist/screens/addtask_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Taskist/widgets/task_tile.dart';

GlobalKey<ScaffoldState> scaffoldstate = GlobalKey<ScaffoldState>();

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              color: kprimaryDarkColor,
              onSelected: (val) {
                switch (val) {
                  case 0:
                    context.read<TaskListModel>().sortBasedOnPriority();
                    break;
                  case 1:
                    context
                        .read<TaskListModel>()
                        .sortBasedOnPriority(order: true);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 0,
                  child: const Text(
                    "Sort by descending order of priority",
                    style: const TextStyle(
                      color: kTextColor,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: const Text(
                    "Sort by Ascending order of priority",
                    style: const TextStyle(
                      color: kTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
          elevation: 0,
          backgroundColor: kprimaryDarkColor,
          automaticallyImplyLeading: false,
          title: const Text(
            "My tasks",
            style: TextStyle(
              fontSize: 40,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            size: 40,
          ),
          onPressed: () {
            scaffoldstate.currentState
                .showBottomSheet(
                  (_) => AddTaskScreen(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  backgroundColor: Colors.blue,
                )
                .closed
                .whenComplete(
              () {
                context.read<DayButtonsModel>().clear();
                for (var field in kfieldList) field.controller.clear();
              },
            );
          },
        ),
        key: scaffoldstate,
        body: Container(
          color: kprimaryDarkColor,
          child: Consumer<TaskListModel>(
            builder: (_, newList, __) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: newList.tasks.length,
                itemBuilder: (_, idx) {
                  return Dismissible(
                    onDismissed: (_) {
                      newList.removeTask(
                        newList.tasks[idx].taskId,
                      );
                    },
                    key: Key(newList.tasks[idx].taskId),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TaskTile(
                        model: newList.tasks[idx],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
