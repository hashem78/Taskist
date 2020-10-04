import 'package:flutter/material.dart';
import 'package:Taskist/constants.dart';
import 'package:flutter/services.dart';

class TaskityTextField extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final String title;
  final String hintText;
  final Function(String) validator;
  final TextInputType keyboardType;
  final maxLines;
  final TextInputAction textInputAction;
  final FocusNode focusNode = FocusNode();
  TaskityTextField({
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
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        textInputAction: textInputAction,
        focusNode: focusNode,
        // onFieldSubmitted: (_) {
        //   print("submitted");
        //   focusNode.unfocus();
        // },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator != null ? ((text) => validator(text)) : null,
        maxLines: maxLines ?? 1,
        //keyboardType: TextInputType.multiline,
        keyboardType: keyboardType ?? TextInputType.multiline,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: const TextStyle(color: kTextColor),
          hintText: hintText,
          hintStyle: const TextStyle(color: ksecondaryTextColor),
          enabledBorder: buildOutlineInputBorder(kaccentColor, 2),
          focusedBorder: buildOutlineInputBorder(kaccentColor, 3),
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
