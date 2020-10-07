import 'package:Taskist/constants.dart';
import 'package:Taskist/cubit/online_tasks_cubit.dart';
import 'package:Taskist/models/task_model.dart';
import 'package:Taskist/models/tasklist_model.dart';
import 'package:Taskist/models/taskpriority_model.dart';
import 'package:Taskist/screens/sorted_tasks_screen.dart';
import 'package:Taskist/components/animated_tasktile.dart';
import 'package:Taskist/widgets/task_tile.dart';
import 'package:Taskist/widgets/widget_block.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/animated_widget_block.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: kprimaryDarkColor,
      systemNavigationBarColor: kprimaryDarkColor,
      systemNavigationBarDividerColor: kprimaryLightColor,
    ),
  );
  var localListModel = await TaskListModel.loadLocalTasks();
  await Firebase.initializeApp();
  runApp(MyApp(localListModel));
}

class MyApp extends StatelessWidget {
  final TaskListModel loadedListModel;
  MyApp(this.loadedListModel);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: kmainScreen,
      routes: {
        ksortedTasksScreen: (context) => SortedTasksScreen(),
        kmainScreen: (context) {
          return BlocProvider(
            create: (_) {
              var cubit = OnlineTasksCubit();
              cubit.firstTimeLoad();
              return cubit;
            },
            child: MainScreen(),
          );
        }
      },
      theme: ThemeData(
        accentColor: kaccentColor,
        primaryColor: kprimaryColor,
        backgroundColor: kprimaryColor,
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingActionButton: AddTaskFAB(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kprimaryDarkColor,
        automaticallyImplyLeading: false,
        title: kappTitle,
        actions: [
          PopupMenuButton(
            color: kprimaryDarkColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            onSelected: (selected) {
              switch (selected) {
                case 0:
                  Navigator.pushNamed(context, ksortedTasksScreen);
                  break;
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 0,
                child: const Text(
                  "Sort by priority",
                  style: TextStyle(
                    color: kTextColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        color: kprimaryDarkColor,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //LocalTaskList(),
              OnlineTasksBlock(),
            ],
          ),
        ),
      ),
    );
  }
}

class OnlineTasksBlock extends StatelessWidget {
  const OnlineTasksBlock({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnlineTasksCubit, OnlineTasksState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is OnlineTasksLoading) {
          return buildLoadingTasks();
        } else if (state is OnlineTasksEmpty) {
          return buildEmptyTasks(state);
        } else if (state is OnlineFirstTimeTasksLoaded) {
          return buildLocalBlockFirstTime(state);
        } else if (state is OnlineTasksLoaded) {
          return buildLocalBlock(state);
        }
        return Container();
      },
      listener: (context, state) {
        if (state is OnlineTasksFailure) {
          buildSnackBar(context, state.message);
        } else if (state is OnlineRemoveTasksSuccess) {
          buildSnackBar(context, state.message);
        }
      },
    );
  }

  AnimatedWidgetBlock buildLocalBlockFirstTime(
      OnlineFirstTimeTasksLoaded state) {
    return AnimatedWidgetBlock(
      title: "Online",
      children: state.taskListModel
          .map(
            (e) => TaskTile(
              model: e,
            ),
          )
          .toList(),
    );
  }

  AnimatedWidgetBlock buildLocalBlock(OnlineTasksLoaded state) {
    return AnimatedWidgetBlock(
      title: "Online",
      children: state.taskListModel
          .map(
            (e) => TaskTile(
              model: e,
            ),
          )
          .toList(),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackBar(
      BuildContext context, String message) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }

  Widget buildEmptyTasks(OnlineTasksEmpty state) {
    return WidgetBlock.empty(
      title: state.title,
      emptyMessage: state.message,
    );
  }

  Widget buildLoadingTasks() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class SyncTasksButton extends StatelessWidget {
  const SyncTasksButton({
    Key key,
    @required this.taskList,
    @required this.actualList,
  }) : super(key: key);

  final TaskListModel taskList;
  final List<TaskModel> actualList;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        taskList.addAll(actualList);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            Icons.sync,
            size: 20,
          ),
          VerticalDivider(
            width: 4,
          ),
          Text(
            "Sync",
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

TaskModel buildTaskModelWithSync(doc) {
  return TaskModel(
    taskId: doc.get('taskId'),
    time: doc.get('time'),
    taskName: doc.get('taskName'),
    repeats: [...doc.get('repeats')],
    notes: doc.get('notes'),
    description: doc.get('description'),
    predicate: doc.get('predicate') == "high"
        ? HighTaskPriorityPredicate()
        : doc.get('predicate') == 'medium'
            ? MediumTaskPriorityPredicate()
            : doc.get('predicate') == 'no'
                ? LowTaskPriorityPredicate()
                : NoPriorityPredicate(),
  );
}
