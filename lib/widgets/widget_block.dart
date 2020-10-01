import 'package:Taskist/widgets/animated_positioned_arrow.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';

class WidgetBlock<E> extends StatelessWidget {
  final List<dynamic> children;
  final String title;
  final bool collapsed;
  final ValueNotifier<bool> collapseNotifier;
  WidgetBlock({
    this.children,
    this.title,
    this.collapsed = false,
  }) : collapseNotifier = ValueNotifier(collapsed);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 5,
              color: kprimaryDarkColor,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(50),
                ),
              ),
              child: Wrap(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w300,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: collapseNotifier,
                    builder: (_, collapsed, __) {
                      if (!collapsed)
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: children.length,
                          itemBuilder: (_, index) {
                            var child = children[index];
                            if (child.model.predicate is E)
                              return child as Widget;
                            return Container();
                          },
                        );
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositionedArrow(notifier: collapseNotifier),
        ],
      ),
    );
  }
}
