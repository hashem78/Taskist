import 'dart:math';

import 'package:Taskist/models/daybuttons_model.dart';
import 'package:Taskist/models/tasklist_model.dart';
import 'package:Taskist/models/taskpriority_model.dart';
import 'package:Taskist/widgets/animated_tasktile.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';
import 'package:Taskist/screens/addtask_screen.dart';
import 'package:provider/provider.dart';
import 'package:Taskist/widgets/animated_widget_block.dart';

GlobalKey<ScaffoldState> mainScreenScafoldState = GlobalKey();

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataList = List.generate(
      context.watch<TaskListModel>().tasks.length,
      (index) {
        return AnimatedTaskTile(
          animationDuration: Duration(
            milliseconds: 200 + 100 * Random().nextInt(5),
          ),
          model: context.watch<TaskListModel>().tasks.values.toList()[index],
        );
      },
    );
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
          onRefresh: () => context.read<TaskListModel>().getOnlineTasks(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              AnimatedWidgetBlock<HighTaskPriorityPredicate>(
                title: "HIGH PRIORITY",
                children: dataList,
              ),
              AnimatedWidgetBlock<LowTaskPriorityPredicate>(
                title: "LOW   PRIORITY",
                children: dataList,
              ),
              AnimatedWidgetBlock<MediumTaskPriorityPredicate>(
                title: "MEDIUM PRIORITY",
                children: dataList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildAddTaskButton(BuildContext context) {
  return FloatingActionButton(
    child: const Icon(
      Icons.add,
      color: kTextColor,
      size: 40,
    ),
    onPressed: () {
      mainScreenScafoldState.currentState
          .showBottomSheet(
            (_) => AddTaskScreen(),
            shape: const RoundedRectangleBorder(
              borderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(50),
                topRight: const Radius.circular(50),
              ),
            ),
            backgroundColor: Colors.blue,
          )
          .closed
          .whenComplete(
        () {
          Provider.of<DayButtonsModel>(context, listen: false).clear();
          kfieldList.forEach(
            (element) {
              element.controller.clear();
            },
          );
        },
      );
    },
  );
}
