import 'package:Taskist/models/radiopriority_model.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';
import 'package:Taskist/screens/addtask_screen.dart';
import 'package:provider/provider.dart';
import 'package:Taskist/models/daybuttons_model.dart';

class AddTaskFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.add,
        color: kTextColor,
        size: 40,
      ),
      onPressed: () {
        Scaffold.of(context)
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
            //Provider.of<TaskListModel>(context, listen: false).rebuild();
            Provider.of<RadioPriorityRowModel>(context, listen: false).clear();
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
}
