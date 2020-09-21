import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';

class TaskTile extends StatelessWidget {
  final String title;

  TaskTile({this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.red,
            child: Text(
              title[0].toUpperCase(),
              style: TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            radius: 30,
          ),
        ),
        Expanded(
          child: Card(
            child: Container(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            color: kprimaryColor,
          ),
        ),
      ],
    );
  }
}
