import 'package:Taskist/constants.dart';
import 'package:Taskist/models/daybuttons_model.dart';
import 'package:Taskist/models/radiopriority_model.dart';
import 'package:Taskist/models/tasklist_model.dart';
import 'package:Taskist/screens/main_screen.dart';
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
