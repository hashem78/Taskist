import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';
import 'package:flutter/services.dart';

class TaskistTextField extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final String title;
  final String hintText;
  final Function(String) validator;
  final TextInputType keyboardType;
  final maxLines;
  final TextInputAction textInputAction;
  final FocusNode focusNode = FocusNode();
  TaskistTextField({
    this.title,
    this.hintText,
    this.validator,
    this.maxLines,
    this.keyboardType,
    this.textInputAction,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        textInputAction: textInputAction,
        focusNode: focusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator != null ? ((text) => validator(text)) : null,
        maxLines: maxLines,
        keyboardType: keyboardType ?? TextInputType.multiline,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(30),
          labelText: title,
          labelStyle: const TextStyle(color: kTextColor),
          hintText: hintText,
          hintStyle: const TextStyle(color: ksecondaryTextColor),
          enabledBorder: buildOutlineInputBorder(Colors.blue, 2),
          focusedBorder: buildOutlineInputBorder(Colors.blue, 3),
          errorBorder: buildOutlineInputBorder(Colors.red, 2),
          focusedErrorBorder: buildOutlineInputBorder(Colors.redAccent, 3),
        ),
        controller: controller,
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: width, color: color),
      borderRadius: const BorderRadius.all(
        const Radius.circular(50),
      ),
    );
  }
}
