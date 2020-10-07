import 'package:Taskist/components/animated_positioned_arrow.dart';
import 'package:Taskist/cubit/online_tasks_cubit.dart';
import 'package:Taskist/models/taskpriority_model.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetBlock extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final bool collapsed;
  final ValueNotifier<bool> collapseNotifier;
  final TaskPriorityPredicate predicate;
  final String emptyMessage;
  WidgetBlock({
    this.children,
    this.title,
    this.collapsed = false,
  })  : collapseNotifier = ValueNotifier(collapsed),
        emptyMessage = null,
        predicate = null;
  WidgetBlock.empty({
    @required this.title,
    @required this.emptyMessage,
    this.collapsed = false,
  })  : children = null,
        collapseNotifier = ValueNotifier(collapsed),
        predicate = null;

  WidgetBlock.sorted({
    this.children,
    this.title,
    this.collapsed = false,
    this.emptyMessage,
    this.predicate,
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
        if (widget.model.predicate != predicate) return Container();
        return Dismissible(
          key: UniqueKey(),
          child: children[index],
          onDismissed: (_) {
            context
                .bloc<OnlineTasksCubit>()
                .removeOnlineTask(widget.model.taskId);
          },
        );
      },
    );
  }
}
