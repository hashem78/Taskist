import 'dart:math';

import 'package:Taskist/models/tasklist_model.dart';
import 'package:Taskist/models/taskpriority_model.dart';
import 'package:Taskist/components/animated_tasktile.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';
import 'package:provider/provider.dart';
import 'package:Taskist/components/animated_widget_block.dart';

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
    var _taskList = Provider.of<TaskListModel>(context, listen: true).tasks;
    var _dataList = _taskList.values
        .map(
          (e) => AnimatedTaskTile(
            model: e,
            animationDuration: Duration(
              milliseconds: 200 + 100 * Random().nextInt(10),
            ),
          ),
        )
        .toList();
    var _blockList = [
      AnimatedWidgetBlock<HighTaskPriorityPredicate>(
        title: "HIGH PRIORITY",
        children: _dataList,
        onChildDismissed: (context, child) {
          context.read<TaskListModel>().removeTask(
                child.model.taskId,
                notify: false,
              );
        },
      ),
      AnimatedWidgetBlock<MediumTaskPriorityPredicate>(
        title: "MEDIUM PRIORITY",
        children: _dataList,
        onChildDismissed: (context, child) {
          context.read<TaskListModel>().removeTask(
                child.model.taskId,
                notify: false,
              );
        },
      ),
      AnimatedWidgetBlock<LowTaskPriorityPredicate>(
        title: "LOW PRIORITY",
        children: _dataList,
        onChildDismissed: (context, child) {
          context
              .read<TaskListModel>()
              .removeTask(child.model.taskId, notify: false);
        },
      ),
    ];
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: _blockList,
    );
  }
}
