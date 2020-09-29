import 'package:Taskist/models/daybuttons_model.dart';
import 'package:Taskist/models/tasklist_model.dart';
import 'package:Taskist/widgets/animated_tasktile.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';
import 'package:Taskist/screens/addtask_screen.dart';
import 'package:provider/provider.dart';

GlobalKey<ScaffoldState> mainScreenScafoldState = GlobalKey();

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainScreenScafoldState,
      floatingActionButton: buildAddTaskButton(context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kprimaryDarkColor,
        automaticallyImplyLeading: false,
        title: kappTitle,
      ),
      body: Container(
        color: kprimaryDarkColor,
        child: RefreshIndicator(
          displacement: 10,
          onRefresh: () {
            context.read<TaskListModel>().getOnlineTasks();
            return Future.delayed(
              Duration(seconds: 1),
            );
          },
          child: AnimatedList(
            key: context.watch<TaskListModel>().animatedListKey,
            initialItemCount: context.watch<TaskListModel>().tasks.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (_, index, animation) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AnimatedTaskTile(
                  model: context
                      .read<TaskListModel>()
                      .tasks
                      .values
                      .toList()[index],
                  animation:
                      Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
                          .animate(
                    animation,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget buildAddTaskButton(BuildContext context) {
  return FloatingActionButton(
    child: Icon(
      Icons.add,
      color: kTextColor,
      size: 40,
    ),
    onPressed: () {
      mainScreenScafoldState.currentState
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
          Provider.of<DayButtonsModel>(context, listen: false).clear();
          kfieldList.forEach((element) {
            element.controller.clear();
          });
        },
      );
    },
  );
}
