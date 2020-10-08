import 'package:Taskist/screens/add_tasks_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:Taskist/widgets/task_tile.dart';
import 'package:Taskist/widgets/widget_block.dart';

import 'components/animated_widget_block.dart';
import 'constants.dart';
import 'cubit/tasks/tasks_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: kmainScreen,
      routes: {
        kmainScreen: (_) => MainScreen(),
        kaddTasksScreen: (_) => AddTaskScreen(),
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
    return BlocProvider(
      create: (_) => TasksCubit(),
      child: Scaffold(
        key: kmainScreenScaffoldKey,
        floatingActionButton: buildFAB(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kprimaryDarkColor,
          automaticallyImplyLeading: false,
          title: Text(kappTitle),
          actions: [
            PopupMenuButton(
              color: kprimaryDarkColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              onSelected: (selected) {},
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
                TasksBlock(
                  onUpdate: (cubit) => cubit.fetchLocal(),
                  blockTitile: "Local",
                ),
                BlocProvider(
                  create: (_) => TasksCubit(),
                  child: TasksBlock(
                    onUpdate: (cubit) => cubit.fetchOnline(),
                    blockTitile: "Online",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFAB() {
    return FloatingActionButton(
      backgroundColor: kprimaryDarkColor,
      child: Icon(
        Icons.add,
        size: 40,
        color: Colors.blue,
      ),
      onPressed: () {
        kmainScreenScaffoldKey.currentState.showBottomSheet(
          (context) => AddTaskScreen(),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
        );
      },
    );
  }
}

class TasksBlock extends StatefulWidget {
  final Function(TasksCubit cubit) onUpdate;
  final String blockTitile;
  TasksBlock({
    Key key,
    @required this.onUpdate,
    @required this.blockTitile,
  }) : super(key: key);

  @override
  _TasksBlockState createState() => _TasksBlockState();
}

class _TasksBlockState extends State<TasksBlock> {
  TasksCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = context.bloc<TasksCubit>();
    widget.onUpdate(cubit);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      // ignore: missing_return
      buildWhen: (s1, s2) {
        if (s1 is TasksLoaded) {
          if (s2 is TasksLoaded) {
            if (s1.tasks.length > s2.tasks.length) {
              return false;
            } else if (s2 is TasksEmpty) {
              return true;
            }
          }
          return true;
        }
      },
      // ignore: missing_return
      builder: (context, state) {
        if (state is TasksLoading) {
          return buildLoadingTasks();
        } else if (state is TasksEmpty) {
          return buildEmptyTasks(state);
        } else if (state is TasksLoaded) {
          return buildLocalBlock(context, state);
        }
        return Container();
      },
      listener: (context, state) {
        if (state is TasksFailure) {
          buildSnackBar(context, state.message);
        }
      },
    );
  }

  AnimatedWidgetBlock buildLocalBlock(BuildContext context, TasksLoaded state) {
    return AnimatedWidgetBlock(
      onChildDismissed: (String id) {
        cubit.remove(id);
        widget.onUpdate(cubit);
      },
      title: widget.blockTitile,
      children: state.tasks.map((e) => TaskTile(model: e)).toList(),
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

  Widget buildEmptyTasks(TasksEmpty state) {
    return WidgetBlock.empty(
      title: widget.blockTitile,
      emptyMessage: state.message,
    );
  }

  Widget buildLoadingTasks() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
