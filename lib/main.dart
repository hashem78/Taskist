import 'package:Taskist/screens/add_tasks.dart';
import 'package:Taskist/screens/main.dart';
import 'package:Taskist/screens/sorted_tasks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants.dart';

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
        ksortedTasksScreen: (_) => SortedTasksScreen(),
      },
      theme: ThemeData(
        accentColor: kaccentColor,
        primaryColor: kprimaryColor,
        backgroundColor: kprimaryColor,
      ),
    );
  }
}
