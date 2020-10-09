import 'package:Taskist/components/animated_widget_block.dart';
import 'package:Taskist/constants.dart';
import 'package:Taskist/cubit/tasks/local/local_tasks_cubit.dart';
import 'package:Taskist/cubit/tasks/online/online_tasks_cubit.dart';
import 'package:Taskist/widgets/task_tile.dart';
import 'package:Taskist/widgets/widget_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  final _onlineTasksCubit = OnlineTasksCubit();
  final _localTasksCubit = LocalTasksCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocalTasksCubit(),
      child: Scaffold(
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
              onSelected: (selected) {},
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
                BlocConsumer<OnlineTasksCubit, OnlineTasksState>(
                  cubit: _onlineTasksCubit,
                  buildWhen: (s1, s2) {
                    if (s2 is OnlineTaskRemoved) return false;
                    return true;
                  },
                  builder: (context, state) {
                    if (state is OnlineTasksInitial) {
                      _onlineTasksCubit.fetch();
                    } else if (state is OnlineTasksLoading) {
                      return buildLoadingTasks();
                    } else if (state is OnlineTasksEmpty) {
                      return buildEmptyTasks('Online', state);
                    } else if (state is OnlineTasksLoaded) {
                      return buildLocalBlock(
                        context,
                        "Online",
                        _onlineTasksCubit,
                        state,
                      );
                    }
                    return Container();
                  },
                  listener: (context, state) {
                    if (state is OnlineTaskRemoved) {
                      Scaffold.of(context).showSnackBar(buildSnackBar());
                    }
                  },
                ),
                BlocConsumer<LocalTasksCubit, LocalTasksState>(
                  cubit: _localTasksCubit,
                  buildWhen: (s1, s2) {
                    if (s2 is LocalTaskRemoved) return false;
                    return true;
                  },
                  builder: (context, state) {
                    if (state is LocalTasksInitial) {
                      _localTasksCubit.fetch();
                    } else if (state is LocalTasksLoading) {
                      return buildLoadingTasks();
                    } else if (state is LocalTasksEmpty) {
                      return buildEmptyTasks('Local', state);
                    } else if (state is LocalTasksLoaded) {
                      return buildLocalBlock(
                        context,
                        "Local",
                        _localTasksCubit,
                        state,
                      );
                    }
                    return Container();
                  },
                  listener: (context, state) {
                    if (state is LocalTaskRemoved) {
                      Scaffold.of(context).showSnackBar(
                        buildSnackBar(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SnackBar buildSnackBar() {
    return SnackBar(
      content: Row(
        children: [
          Text(
            "Would you like to undo the operation?",
            style: TextStyle(color: Colors.blue),
          ),
          IconButton(
            icon: Icon(
              Icons.undo_rounded,
              color: Colors.blue,
              size: 20,
            ),
            onPressed: null,
          ),
        ],
      ),
    );
  }

  Widget buildFAB(BuildContext context) {
    return FloatingActionButton(
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
}

AnimatedWidgetBlock buildLocalBlock(
    BuildContext context, String blockTitle, dynamic cubit, dynamic state) {
  List<Widget> children =
      List<Widget>.from(state.tasks.map((e) => TaskTile(model: e)));
  return AnimatedWidgetBlock(
    onChildDismissed: (String id) async {
      await cubit.remove(id);
      cubit.fetch();
    },
    title: blockTitle,
    children: children,
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackBar(
    BuildContext context, String message) {
  return Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
      ),
    ),
  );
}

Widget buildEmptyTasks(String blockTitle, dynamic state) {
  return WidgetBlock.empty(
    title: blockTitle,
    emptyMessage: state.message,
  );
}

Widget buildLoadingTasks() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
