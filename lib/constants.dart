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

List<TaskityTextField> kfieldList = [
  TaskityTextField(
    title: "Name",
    hintText: "Feed the cats!",
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
