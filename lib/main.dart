import 'package:Taskist/cubit/tasks_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = TasksCubit(localName: 'localData', onlineName: 'tasks');
    return MaterialApp(
      home: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            BlocConsumer<TasksCubit, TasksState>(
              cubit: cubit,
              builder: (context, state) {
                if (state is TasksLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is TasksLoaded) {
                  return ListView.builder(
                    itemCount: state.tasks.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return Text(state.tasks[index].taskName);
                    },
                  );
                } else {
                  return Center(child: Text('rip'));
                }
              },
              listener: (context, state) {},
            ),
            RaisedButton(
              onPressed: () {
                cubit.fetchOnline();
              },
            ),
          ],
        ),
      ),
    );
  }
}
