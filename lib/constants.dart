import 'package:Taskist/widgets/taskist_text_field.dart';
import 'package:flutter/material.dart';

const kprimaryDarkColor = const Color(0xFF455A64);
const kprimaryLightColor = const Color(0xFFCFD8DC);
const kprimaryColor = const Color(0xFF607D8B);
const kTextColor = const Color(0xFFFFFFFF);
const kaccentColor = const Color(0xFF9E9E9E);
const kprimaryTextColor = const Color(0xFF212121);
const ksecondaryTextColor = const Color(0xFFD3D3D3);
const kdividerColor = const Color(0xFFBDBDBD);

const kappTitle = "Taskist";

const kmainScreen = "/";
const kaddTasksScreen = "/addtasks";
const List<String> kdayTitles = const [
  "S",
  "S",
  "M",
  "T",
  "W",
  "T",
  "F",
];
final kmainScreenScaffoldKey = GlobalKey<ScaffoldState>();
List<TaskistTextField> kfieldList = [
  TaskistTextField(
    title: "Name",
    keyboardType: TextInputType.name,
    validator: (text) {
      if (text.length == 0) return "Name has to be atleast 1 character long";
    },
    hintText: "Feed the cats!",
    textInputAction: TextInputAction.done,
    maxLines: 1,
  ),
  TaskistTextField(
    title: "Description",
    hintText: "Describe me bby!",
  ),
  TaskistTextField(
    title: "Notes",
    hintText: "Not the salamon",
  ),
];
