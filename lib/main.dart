import 'package:Taskist/constants.dart';
import 'package:Taskist/models/daybuttons_model.dart';
import 'package:Taskist/models/radiopriority_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:Taskist/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:Taskist/models/tasklist_model.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: kprimaryDarkColor,
      systemNavigationBarColor: kprimaryDarkColor,
      systemNavigationBarDividerColor: kprimaryLightColor,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskListModel(),
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
