import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';
import 'package:flutter/services.dart';

class TaskityTextField extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final String title;
  final String hintText;
  TaskityTextField({this.title, this.hintText});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: TextField(
        maxLines: null,
        //onEditingComplete: () {},
        // textInputAction: TextInputAction.done,
        keyboardType: TextInputType.multiline,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: const TextStyle(color: kTextColor),
          hintText: hintText,
          hintStyle: const TextStyle(color: ksecondaryTextColor),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: kaccentColor),
            borderRadius: const BorderRadius.all(
              const Radius.circular(10),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: kaccentColor),
            borderRadius: const BorderRadius.all(
              const Radius.circular(10),
            ),
          ),
        ),
        controller: controller,
      ),
    );
  }
}
