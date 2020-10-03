import 'package:Taskist/constants.dart';
import 'package:Taskist/models/daybuttons_model.dart';
import 'package:Taskist/models/radiopriority_model.dart';
import 'package:Taskist/models/task_model.dart';
import 'package:Taskist/models/tasklist_model.dart';
import 'package:Taskist/models/taskpriority_model.dart';
import 'package:Taskist/screens/sorted_tasks_screen.dart';
import 'package:Taskist/components/add_task_fab.dart';
import 'package:Taskist/components/animated_tasktile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: loadedListModel,
        ),
        ChangeNotifierProvider(
          create: (_) => RadioPriorityRowModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => DayButtonsModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: kmainScreen,
        routes: {
          ksortedTasksScreen: (context) => SortedTasksScreen(),
          kmainScreen: (context) => MainScreen(),
        },
        theme: ThemeData(
          accentColor: kaccentColor,
          primaryColor: kprimaryColor,
          backgroundColor: kprimaryColor,
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddTaskFAB(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kprimaryDarkColor,
        automaticallyImplyLeading: false,
        title: kappTitle,
        actions: [
          PopupMenuButton(
            onSelected: (selected) {
              switch (selected) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SortedTasksScreen(),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 0,
                child: const Text("Sort by priority"),
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
              LocalTaskList(),
              TaskStreamBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}

class LocalTaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Local",
          style: TextStyle(color: Colors.lightBlueAccent, fontSize: 40),
        ),
        Consumer<TaskListModel>(
          builder: (_, taskList, __) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: taskList.tasks.length,
              itemBuilder: (___, index) {
                var model = taskList.tasks.values.toList()[index];
                return Dismissible(
                  onDismissed: (_) =>
                      taskList.removeTask(model.taskId, notify: false),
                  key: UniqueKey(),
                  child: AnimatedTaskTile(
                    model: model,
                    animationDuration: Duration(milliseconds: 200),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class TaskStreamBuilder extends StatelessWidget {
  const TaskStreamBuilder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("here");
    var taskList = Provider.of<TaskListModel>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
      builder: (_, snapshot) {
        if (!snapshot.hasData || snapshot == null)
          return CircularProgressIndicator();
        var docs = snapshot.data.docs;
        var actualList = <TaskModel>[];
        for (var doc in docs) {
          var tmodel = buildTaskModelWithSync(doc);
          if (!taskList.contains(tmodel.taskId)) actualList.add(tmodel);
        }
        if (actualList.length != 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                thickness: 1,
              ),
              Text(
                "Online",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.lightBlueAccent,
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: actualList.length,
                itemBuilder: (_, index) {
                  return AnimatedTaskTile(
                    model: actualList[index],
                    animationDuration: Duration(milliseconds: 200),
                  );
                },
              ),
              Center(
                child: SyncTasksButton(
                  taskList: taskList,
                  actualList: actualList,
                ),
              ),
            ],
          );
        }
        return Container();
      },
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
            : LowTaskPriorityPredicate(),
  );
}
