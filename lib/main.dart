import 'package:Taskist/constants.dart';
import 'package:Taskist/models/daybuttons_model.dart';
import 'package:Taskist/models/radiopriority_model.dart';
import 'package:flutter/material.dart';

import 'package:Taskist/models/task_model.dart';

import 'package:flutter/services.dart';
import 'package:Taskist/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:Taskist/models/tasklist_model.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: kprimaryDarkColor,
      systemNavigationBarColor: kprimaryDarkColor,
      systemNavigationBarDividerColor: kprimaryLightColor,
    ),
  );

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TaskListModel.load(),
      builder: (_, AsyncSnapshot<List<TaskModel>> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => TaskListModel(snapshot.data),
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
              kmainScreen: (context) => MainScreen(),
            },
            theme: ThemeData(
              accentColor: kaccentColor,
              primaryColor: kprimaryColor,
              backgroundColor: kprimaryColor,
            ),
          ),
        );
      },
    );
  }
}
