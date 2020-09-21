import 'package:Taskist/constants.dart';
import 'package:Taskist/models/task_model.dart';
import 'package:Taskist/models/tasklist_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

GlobalKey<ScaffoldState> scaffoldstate = GlobalKey<ScaffoldState>();

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        //resizeToAvoidBottomPadding: false,
        key: scaffoldstate,
        body: Container(
          color: kprimaryDarkColor,
//          height: MediaQuery.of(context).size.height,
//          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              RaisedButton(
                onPressed: () {
                  scaffoldstate.currentState.showBottomSheet(
                    (context) => buildBottomSheetContainer(context),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    backgroundColor: Colors.blue,
                  );
                },
              ),
              Consumer<TaskListModel>(builder: (_, newList, __) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: newList.tasks.length,
                    itemBuilder: (_, idx) {
                      return Text(newList.tasks.toList()[idx].taskName);
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBottomSheetContainer(BuildContext context) {
    var fieldList = <TaskityTextField>[
      TaskityTextField(
        title: "Name",
        hintText: "Feed the cats!",
      ),
      TaskityTextField(
        title: "Notes",
        hintText: "Not the salamon",
      ),
    ];
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.5,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              padding: EdgeInsets.all(30),
              child: Text(
                "New Task",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: kTextColor,
                ),
              ),
            ),
            for (var item in fieldList) item,
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              color: kprimaryDarkColor,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Add Task",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 20,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () {
                context.read<TaskListModel>().addTask(
                      TaskModel(
                        taskName: fieldList[0]._controller.text,
                        time: fieldList[1]._controller.text,
                        repeats: [],
                      ),
                    );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TaskityTextField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final String title;
  final String hintText;
  TaskityTextField({this.title, this.hintText});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: TextField(
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: TextStyle(color: kTextColor),
          hintText: hintText,
          hintStyle: TextStyle(color: kTextColor),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: kaccentColor),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: kaccentColor),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        controller: _controller,
      ),
    );
  }
}
