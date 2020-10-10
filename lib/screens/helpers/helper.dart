import 'package:Taskist/widgets/widget_block.dart';
import 'package:flutter/material.dart';

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

Widget buildRemovedTaskSnackBar() => SnackBar(
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
