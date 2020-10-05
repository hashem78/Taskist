import 'package:flutter/material.dart';
import 'package:Taskist/widgets/taskist_textfield.dart';

const kprimaryDarkColor = const Color(0xFF455A64);
const kprimaryLightColor = const Color(0xFFCFD8DC);
const kprimaryColor = const Color(0xFF607D8B);
const kTextColor = const Color(0xFFFFFFFF);
const kaccentColor = const Color(0xFF9E9E9E);
const kprimaryTextColor = const Color(0xFF212121);
const ksecondaryTextColor = const Color(0xFFD3D3D3);
const kdividerColor = const Color(0xFFBDBDBD);

const kappTitle = const Text(
  "Taskist",
  style: const TextStyle(
    fontSize: 40,
  ),
);
var kpopupMenuItems = [
  const PopupMenuItem(
    value: 0,
    child: const Text(
      "Sort by descending order of priority",
      style: const TextStyle(
        color: kTextColor,
      ),
    ),
  ),
  const PopupMenuItem(
    value: 1,
    child: const Text(
      "Sort by Ascending order of priority",
      style: const TextStyle(
        color: kTextColor,
      ),
    ),
  ),
  const PopupMenuItem(
    value: 2,
    child: const Text(
      "Sync",
      style: const TextStyle(
        color: kTextColor,
      ),
    ),
  ),
];
List<TaskityTextField> kfieldList = [
  TaskityTextField(
    title: "Name",
    keyboardType: TextInputType.name,
    validator: (text) {
      if (text.length == 0) return "Name has to be atleast 1 character long";
    },
    hintText: "Feed the cats!",
    textInputAction: TextInputAction.done,
    maxLines: 1,
  ),
  TaskityTextField(
    title: "Description",
    hintText: "Describe me bby!",
  ),
  TaskityTextField(
    title: "Notes",
    hintText: "Not the salamon",
  ),
];
const List<String> kdayTitles = const [
  "S",
  "S",
  "M",
  "T",
  "W",
  "T",
  "F",
];
const kmainScreen = '/';
const ksortedTasksScreen = '/sorted';
