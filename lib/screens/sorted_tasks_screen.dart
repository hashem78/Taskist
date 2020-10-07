import 'package:Taskist/components/animated_tasktile.dart';
import 'package:Taskist/components/animated_widget_block.dart';
import 'package:Taskist/cubit/high/filtered_high_cubit.dart';
import 'package:Taskist/cubit/low/filtered_low_cubit.dart';
import 'package:Taskist/cubit/medium/filtered_medium_cubit.dart';
import 'package:Taskist/cubit/none/filtered_none_cubit.dart';
import 'package:Taskist/models/task_model.dart';
import 'package:Taskist/widgets/widget_block.dart';
import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum High { Filt }

class FilteredTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kprimaryDarkColor,
        title: kappTitle,
      ),
      body: Container(
        color: kprimaryDarkColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            BlocConsumer<FilteredHighCubit, FilteredHighState>(
              buildWhen: (s1, s2) {
                if (s2 is FilteredHighRemoveSuccess) return false;
                return true;
              },
              // ignore: missing_return
              builder: (context, state) {
                if (state is FilteredHighLoading) {
                  return buildLoading();
                } else if (state is FilteredHighEmpty) {
                  return buildEmpty("High", state.message);
                } else if (state is FilteredHighLoaded) {
                  return buildBlock(
                    state.taskListModel,
                    "High",
                    (String id) {
                      context.bloc<FilteredHighCubit>().removeOnlineTask(id);
                    },
                  );
                }
              },
              listener: (context, state) {
                if (state is FilteredHighRemoveSuccess) {
                  buildShowSnackBar(context, state.message);
                } else if (state is FilteredHighFailure) {
                  buildShowSnackBar(context, state.message);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildShowSnackBar(
      BuildContext context, String message) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Widget buildBlock(List<TaskModel> taskListModel, String title,
      Function(String) onChildDismissed) {
    return AnimatedWidgetBlock(
      title: title,
      children: taskListModel
          .map(
            (e) => AnimatedTaskTile(
              model: e,
              animationDuration: Duration(
                milliseconds: 200,
              ),
            ),
          )
          .toList(),
      onChildDismissed: onChildDismissed,
    );
  }

  Widget buildEmpty(String title, String emptyMessage) {
    return WidgetBlock.empty(
      title: title,
      emptyMessage: emptyMessage,
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
// BlocConsumer<FilteredMediumCubit, FilteredMediumState>(
//               // ignore: missing_return
//               buildWhen: (s1, s2) {
//                 if (s2 is FilteredMediumRemoveSuccess) return false;
//                 return true;
//               },
//               builder: (context, state) {
//                 if (state is FilteredMediumLoading) {
//                   return buildLoading();
//                 } else if (state is FilteredMediumEmpty) {
//                   return buildEmpty("High", state.message);
//                 } else if (state is FilteredMediumLoaded) {
//                   return buildBlock(
//                     state.taskListModel,
//                     "Medium",
//                     (String id) {
//                       context.bloc<FilteredMediumCubit>().removeOnlineTask(id);
//                     },
//                   );
//                 }
//               },
//               listener: (context, state) {
//                 if (state is FilteredMediumRemoveSuccess) {
//                   buildShowSnackBar(context, state.message);
//                 } else if (state is FilteredMediumFailure) {
//                   buildShowSnackBar(context, state.message);
//                 }
//               },
//             ),
//             BlocConsumer<FilteredLowCubit, FilteredLowState>(
//               // ignore: missing_return
//               buildWhen: (s1, s2) {
//                 if (s2 is FilteredLowRemoveSuccess) return false;
//                 return true;
//               },
//               builder: (context, state) {
//                 if (state is FilteredLowLoading) {
//                   return buildLoading();
//                 } else if (state is FilteredLowEmpty) {
//                   return buildEmpty("High", state.message);
//                 } else if (state is FilteredLowLoaded) {
//                   return buildBlock(
//                     state.taskListModel,
//                     "Low",
//                     (String id) {
//                       context.bloc<FilteredLowCubit>().removeOnlineTask(id);
//                     },
//                   );
//                 }
//               },
//               listener: (context, state) {
//                 if (state is FilteredLowRemoveSuccess) {
//                   buildShowSnackBar(context, state.message);
//                 } else if (state is FilteredLowFailure) {
//                   buildShowSnackBar(context, state.message);
//                 }
//               },
//             ),
//             BlocConsumer<FilteredNoneCubit, FilteredNoneState>(
//               buildWhen: (s1, s2) {
//                 if (s2 is FilteredNoneRemoveSuccess) return false;
//                 return true;
//               },
//               // ignore: missing_return
//               builder: (context, state) {
//                 if (state is FilteredNoneLoading) {
//                   return buildLoading();
//                 } else if (state is FilteredNoneEmpty) {
//                   return buildEmpty("High", state.message);
//                 } else if (state is FilteredNoneLoaded) {
//                   return buildBlock(
//                     state.taskListModel,
//                     "None",
//                     (String id) {
//                       context.bloc<FilteredNoneCubit>().removeOnlineTask(id);
//                     },
//                   );
//                 }
//               },
//               listener: (context, state) {
//                 if (state is FilteredNoneRemoveSuccess) {
//                   buildShowSnackBar(context, state.message);
//                 } else if (state is FilteredNoneFailure) {
//                   buildShowSnackBar(context, state.message);
//                 }
//               },
//             ),
