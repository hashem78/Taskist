import 'package:Taskist/constants.dart';
import 'package:Taskist/cubit/tasks/local/local_tasks_cubit.dart';
import 'package:Taskist/cubit/tasks/online/online_tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'helpers/main_screen.dart';

class MainScreen extends StatelessWidget {
  final _onlineTasksCubit = OnlineTasksCubit();
  final _localTasksCubit = LocalTasksCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: kmainScreenScaffoldKey,
      floatingActionButton: BlocProvider.value(
        value: _localTasksCubit,
        child: buildFAB(context),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kprimaryDarkColor,
        automaticallyImplyLeading: false,
        title: Text(kappTitle),
        actions: [
          PopupMenuButton(
            color: kprimaryDarkColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            onSelected: (selected) {
              switch (selected) {
                case 0:
                  Navigator.pushNamed(context, ksortedTasksScreen).then(
                    (value) => _onlineTasksCubit.fetch(),
                  );
                  break;
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 0,
                child: const Text(
                  "Sort by priority",
                  style: TextStyle(
                    color: kTextColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        color: kprimaryDarkColor,
        height: MediaQuery.of(context).size.height,
        child: RefreshIndicator(
          onRefresh: () async {
            await _onlineTasksCubit.fetch();
          },
          child: ListView(
            children: [
              buildCommonConsumer(_onlineTasksCubit, "Online"),
              buildCommonConsumer(_localTasksCubit, "Local"),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFAB(BuildContext context) => FloatingActionButton(
        backgroundColor: kprimaryDarkColor,
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.blue,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(kaddTasksScreen).then((value) {
            if (value != null) _localTasksCubit.add(value);
            kfieldList.forEach((element) => element.controller.clear());
          });
        }, // showModalBottomSheet<TaskModel>(
      );
}
