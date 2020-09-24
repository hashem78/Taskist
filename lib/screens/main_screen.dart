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
        floatingActionButton: FloatingActionButton(
          child: Icon(
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
                itemCount: newList.tasks.length,
                itemBuilder: (_, idx) {
                  return Dismissible(
                    onDismissed: (_) {
                      newList.removeTask(
                        newList.tasks.values.toList()[idx].taskId,
                      );
                    },
                    key: Key(newList.tasks.values.toList()[idx].taskId),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TaskTile(
                        model: newList.tasks.values.toList()[idx],
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
