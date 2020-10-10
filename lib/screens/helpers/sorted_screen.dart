import 'package:Taskist/cubit/tasks/common_state.dart';
import 'package:Taskist/models/task_predicate.dart';
import 'package:Taskist/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Taskist/components/animated_widget_block.dart';

import 'helper.dart';

Widget buildLocalBlock(BuildContext context, String blockTitle, cubit,
    dynamic state, TaskPriorityPredicate predicate) {
  List<Widget> children =
      List<Widget>.from(state.tasks.map((e) => TaskTile(model: e)));
  return AnimatedWidgetBlock(
    onChildDismissed: (String id) async {
      await cubit.removeFiltered(id, predicate);
    },
    title: blockTitle,
    children: children,
  );
}

Widget buildCommonConsumer<C extends Cubit<S>, S>(
        dynamic cubit, String title, TaskPriorityPredicate predicate) =>
    BlocConsumer<C, S>(
      cubit: cubit,
      buildWhen: (s1, s2) {
        if (s2 is CommonTaskRemoved) return false;
        return true;
      },
      builder: (context, state) {
        if (state is CommonTasksInitial) {
          cubit.filter(predicate);
        } else if (state is CommonTasksLoading) {
          return buildLoadingTasks();
        } else if (state is CommonTasksEmpty) {
          return buildEmptyTasks(title, state);
        } else if (state is CommonTasksLoaded) {
          return buildLocalBlock(context, title, cubit, state, predicate);
        }
        return Container();
      },
      listener: (context, state) {
        if (state is CommonTaskRemoved) {
          Scaffold.of(context).showSnackBar(buildRemovedTaskSnackBar());
        }
      },
    );
