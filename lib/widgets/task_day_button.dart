import 'package:Taskist/constants.dart';
import 'package:flutter/material.dart';

class TaskDayButton extends StatelessWidget {
  final Color activated = Colors.red;
  final Color deactivated = Colors.grey;
  final String title;
  final int index;
  final bool isActive;
  TaskDayButton({this.title, this.index}) : isActive = null;
  TaskDayButton.noModel({this.title, this.isActive}) : index = null;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        child: InkWell(
          splashColor: Colors.grey, // inkwell color
          child: Container(
            width: 35,
            height: 35,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: kTextColor,
                ),
              ),
            ),
          ),
          onTap: () {
            //if (index != null) newList.triggerAtIndex(index);
          },
        ),
      ),
    );
  }
}
