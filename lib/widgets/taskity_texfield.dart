import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';

class TaskityTextField extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
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
        controller: controller,
      ),
    );
  }
}
