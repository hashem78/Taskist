import 'package:Taskist/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/models/task_model.dart';

class AnimatedTaskTile extends StatelessWidget {
  final Animation<Offset> animation;
  final TaskTile taskTile;
  AnimatedTaskTile({
    @required TaskModel model,
    @required this.animation,
  }) : taskTile = TaskTile(model: model);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SlideTransition(
          position: animation,
          child: taskTile,
        );
      },
    );
  }
}
