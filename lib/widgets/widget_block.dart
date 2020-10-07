import 'package:Taskist/components/animated_positioned_arrow.dart';
import 'package:Taskist/constants.dart';
import 'package:flutter/material.dart';

class WidgetBlock extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final bool collapsed;
  final ValueNotifier<bool> collapseNotifier;
  final String emptyMessage;
  final Function(String) onChildDismissed;
  WidgetBlock({
    this.children,
    this.title,
    this.collapsed = false,
    this.onChildDismissed,
  })  : collapseNotifier = ValueNotifier(collapsed),
        emptyMessage = null;
  WidgetBlock.empty({
    @required this.title,
    @required this.emptyMessage,
    this.collapsed = false,
  })  : children = null,
        collapseNotifier = ValueNotifier(collapsed),
        onChildDismissed = null;

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
            child: Container(
              width: MediaQuery.of(context).size.width,
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
                      if (!collapsed) {
                        if (children != null)
                          return buildListView();
                        else {
                          return buildEmptyTasks();
                        }
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedPositionedArrow(notifier: collapseNotifier),
      ],
    );
  }

  Text buildEmptyTasks() {
    return Text(
      emptyMessage,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.lightBlueAccent,
        fontSize: 40,
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: children.length,
      itemBuilder: (context, index) {
        var widget = (children[index] as dynamic);
        return Dismissible(
          key: UniqueKey(),
          child: widget,
          onDismissed: (_) => onChildDismissed(widget.model.taskId),
        );
      },
    );
  }
}
