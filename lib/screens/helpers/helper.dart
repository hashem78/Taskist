import 'package:Taskist/models/task.dart';
import 'package:Taskist/widgets/widget_block.dart';
import 'package:flutter/material.dart';

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

Widget buildRemovedTaskSnackBar(dynamic cubit, TaskModel model) => SnackBar(
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          cubit.add(model);
        },
      ),
      content: Text(
        "Would you like to undo the operation?",
        style: TextStyle(color: Colors.blue),
      ),
    );
