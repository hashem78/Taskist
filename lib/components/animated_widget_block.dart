import 'dart:math';

import 'package:flutter/material.dart';
import 'package:Taskist/widgets/widget_block.dart';

class AnimatedWidgetBlock extends StatefulWidget {
  final List<dynamic> children;
  final WidgetBlock wblock;
  final Function() onChildDismissed;
  final String title;
  AnimatedWidgetBlock({
    @required this.children,
    this.title,
    this.onChildDismissed,
  }) : wblock = WidgetBlock(
          children: children,
          title: title,
        );
  @override
  _AnimatedWidgetBlockState createState() => _AnimatedWidgetBlockState();
}

class _AnimatedWidgetBlockState extends State<AnimatedWidgetBlock>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInCirc,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: widget.wblock,
      builder: (_, child) {
        return FadeTransition(
          opacity: animation,
          child: widget.wblock,
        );
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
