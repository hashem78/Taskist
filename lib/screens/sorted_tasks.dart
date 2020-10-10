import 'package:Taskist/constants.dart';
import 'package:Taskist/cubit/tasks/local/local_tasks_cubit.dart';
import 'package:Taskist/cubit/tasks/online/online_tasks_cubit.dart';
import 'package:Taskist/models/task_predicate.dart';
import 'package:flutter/material.dart';

import 'helpers/sorted_screen.dart';

class SortedTasksScreen extends StatefulWidget {
  @override
  _SortedTasksScreenState createState() => _SortedTasksScreenState();
}

class _SortedTasksScreenState extends State<SortedTasksScreen> {
  bool _reversed = false;
  @override
  Widget build(BuildContext context) {
    var _list = [
      buildCommonConsumer(
          OnlineTasksCubit(), "High", HighTaskPriorityPredicate()),
      buildCommonConsumer(
          OnlineTasksCubit(), "Medium", MediumTaskPriorityPredicate()),
      buildCommonConsumer(
          OnlineTasksCubit(), "Low", LowTaskPriorityPredicate()),
      buildCommonConsumer(OnlineTasksCubit(), "None", NoPriorityPredicate()),
      Divider(
        height: 10,
        color: Colors.red,
        thickness: 4,
        indent: 10,
        endIndent: 10,
      ),
      buildCommonConsumer(
          LocalTasksCubit(), "High", HighTaskPriorityPredicate()),
      buildCommonConsumer(
          LocalTasksCubit(), "Medium", MediumTaskPriorityPredicate()),
      buildCommonConsumer(LocalTasksCubit(), "Low", LowTaskPriorityPredicate()),
      buildCommonConsumer(LocalTasksCubit(), "None", NoPriorityPredicate()),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kprimaryDarkColor,
        title: Text(kappTitle),
        actions: [
          IconButton(
              icon: Icon(
                Icons.sort_rounded,
                color: _reversed ? Colors.blue : null,
              ),
              onPressed: () {
                setState(() {
                  _reversed = !_reversed;
                });
              }),
        ],
      ),
      body: Container(
        color: kprimaryDarkColor,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          addAutomaticKeepAlives: true,
          children: _reversed ? _list.reversed.toList() : _list,
        ),
      ),
    );
  }
}
