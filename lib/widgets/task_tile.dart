import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final Color priorityColor;

  TaskTile({this.title, this.priorityColor});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
      child: Material(
        color: priorityColor,
        child: InkWell(
          onTap: () {},
          splashColor: Colors.grey,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    title,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
