import 'package:Taskist/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/models/task.dart';

class AnimatedTaskTile extends StatefulWidget {
  final TaskTile taskTile;
  final Duration animationDuration;
  final TaskModel model;
  AnimatedTaskTile({
    @required this.model,
    this.animationDuration,
  }) : taskTile = TaskTile(model: model);

  @override
  _AnimatedTaskTileState createState() => _AnimatedTaskTileState();
}

class _AnimatedTaskTileState extends State<AnimatedTaskTile>
    with TickerProviderStateMixin {
  Animation<Offset> animation;
  AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..forward();
    animation = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (_, child) {
        return SlideTransition(
          position: animation,
          child: widget.taskTile,
        );
      },
      child: widget.taskTile,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
