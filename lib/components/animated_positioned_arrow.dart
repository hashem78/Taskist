import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedPositionedArrow extends StatefulWidget {
  final ValueNotifier<bool> notifier;
  AnimatedPositionedArrow({this.notifier});
  @override
  _AnimatedPositionedArrowState createState() =>
      _AnimatedPositionedArrowState();
}

class _AnimatedPositionedArrowState extends State<AnimatedPositionedArrow>
    with TickerProviderStateMixin {
  bool collapsed = false;
  AnimationController arrowController;
  Animation<double> arrowAnimation;
  @override
  void initState() {
    arrowController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    arrowAnimation = Tween<double>(begin: 0, end: pi).animate(arrowController);
    ValueNotifier(collapsed);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 30,
      child: Align(
        alignment: Alignment.topRight,
        child: AnimatedBuilder(
          animation: arrowController,
          builder: (_, child) {
            return Transform.rotate(
              angle: arrowAnimation.value,
              child: child,
            );
          },
          child: IconButton(
            onPressed: () {
              if (!widget.notifier.value)
                arrowController..forward();
              else
                arrowController.reverse();
              widget.notifier.value = !widget.notifier.value;
              //widget.notifier.notifyListeners();
            },
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.lightBlueAccent,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    arrowController.dispose();
    super.dispose();
  }
}
