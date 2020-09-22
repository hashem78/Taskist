import 'package:Taskist/constants.dart';
import 'package:Taskist/models/daybuttons_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskDayButton extends StatelessWidget {
  final Function() onTap;
  final Color _activated = Colors.red;
  final Color _deactivated = Colors.grey;
  final String title;
  final int index;
  TaskDayButton({this.onTap, this.title, this.index});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Consumer<DayButtonsModel>(
        builder: (_, newList, __) => Material(
          color: newList.getAtIndex(index)
              ? _activated
              : _deactivated, // button color
          child: InkWell(
            splashColor: Colors.grey, // inkwell color
            child: Container(
              width: 35,
              height: 35,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: kTextColor,
                  ),
                ),
              ),
            ),
            onTap: () {
              newList.triggerAtIndex(index);
            },
          ),
        ),
      ),
    );
  }
}
