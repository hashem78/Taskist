import 'package:Taskist/constants.dart';
import 'package:Taskist/models/daybuttons_model.dart';
import 'package:Taskist/models/tasklist_model.dart';
import 'package:Taskist/models/taskpriority_model.dart';
import 'package:Taskist/screens/addtask_screen.dart';
import 'package:Taskist/widgets/task_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Taskist/models/task_model.dart';

GlobalKey<ScaffoldState> scaffoldstate = GlobalKey<ScaffoldState>();

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              color: kprimaryDarkColor,
              onSelected: (val) {
                switch (val) {
                  case 0:
                    context.read<TaskListModel>().sortBasedOnPriority();
                    break;
                  case 1:
                    context
                        .read<TaskListModel>()
                        .sortBasedOnPriority(order: true);
                    break;
                  case 2:
                    context.read<TaskListModel>().triggerSync();
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 0,
                  child: const Text(
                    "Sort by descending order of priority",
                    style: const TextStyle(
                      color: kTextColor,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: const Text(
                    "Sort by Ascending order of priority",
                    style: const TextStyle(
                      color: kTextColor,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: const Text(
                    "Sync",
                    style: const TextStyle(
                      color: kTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
          elevation: 0,
          backgroundColor: kprimaryDarkColor,
          automaticallyImplyLeading: false,
          title: Text(
            context.watch<TaskListModel>().syncWithOnline
                ? "Online"
                : "Not online",
            style: TextStyle(
              fontSize: 40,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
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
          child: context.watch<TaskListModel>().syncWithOnline
              ? buildMainScreenStream(context)
              : buildMainScreenConsumer(),
        ),
      ),
    );
  }

  StreamBuilder buildMainScreenStream(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
      builder: (_, snapshots) {
        if (!snapshots.hasData || snapshots.data == null) {
          return Center(
            child: Container(
              color: Colors.transparent,
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshots.data.documents.length == 0)
          return Center(
            child: Container(
              child: Text(
                "No notes to fetch!",
                style: TextStyle(
                  fontSize: 50,
                  color: ksecondaryTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: snapshots.data.documents.length,
          itemBuilder: (_, idx) {
            var doc = snapshots.data.documents[idx];
            var tmodel = buildTaskModelWithSync(doc);

            return Dismissible(
              onDismissed: (_) async {
                await context.read<TaskListModel>().removeTask(
                      tmodel.taskId,
                    );
              },
              key: Key(tmodel.taskId),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TaskTile(
                  model: tmodel,
                ),
              ),
            );

            //return buildTaskTilesWithSync(doc)
          },
        );
      },
    );
  }
}

Consumer<TaskListModel> buildMainScreenConsumer() {
  return Consumer<TaskListModel>(
    builder: (_, newList, __) {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: newList.tasks.length,
        itemBuilder: (_, idx) {
          return Dismissible(
            onDismissed: (_) {
              newList.removeTask(
                newList.tasks[idx].taskId,
              );
            },
            key: Key(newList.tasks[idx].taskId),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TaskTile(
                model: newList.tasks[idx],
              ),
            ),
          );
        },
      );
    },
  );
}

TaskModel buildTaskModelWithSync(doc) {
  return TaskModel(
    taskId: doc.get('taskId'),
    time: doc.get('time'),
    taskName: doc.get('taskName'),
    repeats: [...doc.get('repeats')],
    notes: doc.get('notes'),
    description: doc.get('description'),
    priority: doc.get('priority') == "high"
        ? HighTaskPriority("")
        : doc.get('priority') == 'medium'
            ? MediumTaskPriority("")
            : LowTaskPriority(""),
  );
}
