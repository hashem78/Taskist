import 'package:flutter/material.dart';
import 'package:Taskist/widgets/widget_block.dart';

class AnimatedWidgetBlock<E> extends StatefulWidget {
  final List<dynamic> children;
  final WidgetBlock<E> wblock;
  final Function(BuildContext, dynamic) onChildDismissed;
  final String title;
  AnimatedWidgetBlock({
    @required this.children,
    this.title,
    this.onChildDismissed,
  }) : wblock = WidgetBlock<E>(
          children: children,
          title: title,
          onChildDismissed: onChildDismissed,
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
      duration: const Duration(milliseconds: 300),
    )..forward();
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: widget.wblock,
      builder: (_, child) {
        return SizeTransition(
          sizeFactor: animation,
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
