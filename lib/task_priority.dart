import 'package:flutter/material.dart';

abstract class TaskPriority {
  Color color;
  String alert;
}

class HighTaskPriority extends TaskPriority {
  HighTaskPriority(String alert) {
    super.color = Colors.redAccent;
    super.alert = alert;
  }
}

class MediumTaskPriority extends TaskPriority {
  MediumTaskPriority(String alert) {
    super.color = Colors.amberAccent;
    super.alert = alert;
  }
}

class LowTaskPriority extends TaskPriority {
  LowTaskPriority(String alert) {
    super.color = Colors.greenAccent;
    super.alert = alert;
  }
}
