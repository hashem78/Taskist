import 'package:Taskist/constants.dart';
import 'package:flutter/material.dart';

class TaskDayButton extends StatelessWidget {
  final Color activated = Colors.red;
  final Color deactivated = Colors.grey;
  final String title;
  final bool isActive;
  final Function() onTap;
  TaskDayButton({
    @required this.title,
    @required this.onTap,
    @required this.isActive,
  });
  TaskDayButton.ignore({
    @required this.title,
    @required this.isActive,
  }) : this.onTap = null;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Material(
        child: InkWell(
          splashColor: Colors.grey, // inkwell color
          child: Container(
            width: 35,
            height: 35,
            color: isActive ? Colors.green : Colors.grey,
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
          onTap: onTap,
        ),
      ),
    );
  }
}
