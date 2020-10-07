import 'package:Taskist/models/tasklist_model.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';
import 'package:provider/provider.dart';

class SortedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kprimaryDarkColor,
        title: kappTitle,
      ),
      body: Container(
        color: kprimaryDarkColor,
        child: AnimatedWidgetBlockList(),
      ),
    );
  }
}

class AnimatedWidgetBlockList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var _taskList = Provider.of<TaskListModel>(context, listen: true).tasks;
    var _blockList = [
      // AnimatedWidgetBlock<HighTaskPriorityPredicate>(
      //   title: "HIGH PRIORITY",
      //   children: _dataList,
      //   onChildDismissed: (context, child) {
      //     context.read<TaskListModel>().removeTask(
      //           child.model.taskId,
      //           notify: false,
      //         );
      //   },
      // ),
      // AnimatedWidgetBlock<MediumTaskPriorityPredicate>(
      //   title: "MEDIUM PRIORITY",
      //   children: _dataList,
      //   onChildDismissed: (context, child) {
      //     context.read<TaskListModel>().removeTask(
      //           child.model.taskId,
      //           notify: false,
      //         );
      //   },
      // ),
      // AnimatedWidgetBlock<LowTaskPriorityPredicate>(
      //   title: "LOW PRIORITY",
      //   children: _dataList,
      //   onChildDismissed: (context, child) {
      //     context
      //         .read<TaskListModel>()
      //         .removeTask(child.model.taskId, notify: false);
      //   },
      // ),
      // AnimatedWidgetBlock<NoPriorityPredicate>(
      //   title: "NO     PRIORITY",
      //   children: _dataList,
      //   onChildDismissed: (context, child) {
      //     context
      //         .read<TaskListModel>()
      //         .removeTask(child.model.taskId, notify: false);
      //   },
      // ),
    ];
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: _blockList,
    );
  }
}
