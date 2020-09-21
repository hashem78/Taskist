import 'package:Taskist/constants.dart';
import 'package:Taskist/models/tasklist_model.dart';
import 'package:Taskist/screens/addtask_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Taskist/widgets/taskity_texfield.dart';
import 'package:Taskist/widgets/task_tile.dart';

GlobalKey<ScaffoldState> scaffoldstate = GlobalKey<ScaffoldState>();

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 40,
          ),
          onPressed: () {
            scaffoldstate.currentState.showBottomSheet(
              (context) => buildBottomSheetContainer(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              backgroundColor: Colors.blue,
            );
          },
        ),
        key: scaffoldstate,
        body: Container(
          color: kprimaryDarkColor,
          child: Consumer<TaskListModel>(
            builder: (_, newList, __) {
              return ListView.builder(
                itemCount: newList.tasks.length,
                itemBuilder: (_, idx) {
                  return Dismissible(
                    onDismissed: (_) {
                      newList.removeTask(newList.tasks.toList()[idx].taskId);
                    },
                    key: newList.tasks.toList()[idx].taskId,
                    child: TaskTile(
                      title: newList.tasks.toList()[idx].taskName,
                      priorityColor: newList.tasks.toList()[idx].priority.color,
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

  Widget buildBottomSheetContainer(BuildContext context) {
    return AddTaskScreen();
  }
}
