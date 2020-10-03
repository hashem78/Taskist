import 'package:Taskist/components/animated_positioned_arrow.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';

class WidgetBlock<E> extends StatelessWidget {
  final List<dynamic> children;
  final String title;
  final bool collapsed;
  final ValueNotifier<bool> collapseNotifier;
  final Function(BuildContext, dynamic) onChildDismissed;
  WidgetBlock({
    this.children,
    this.title,
    this.collapsed = false,
    this.onChildDismissed,
  }) : collapseNotifier = ValueNotifier(collapsed);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w300,
                      color: Colors.lightBlueAccent,
                    ),
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
                        itemBuilder: (context, index) {
                          var child = children[index];
                          try {
                            if (child.model.predicate is E)
                              return Dismissible(
                                key: UniqueKey(),
                                child: child,
                                onDismissed: (_) {
                                  onChildDismissed(context, child);
                                  children.remove(child);
                                },
                              );
                          } catch (e) {
                            if (e is NoSuchMethodError)
                              print(
                                  "widget does not have the right model, thus is not supported!");
                          }
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
    );
  }
}
