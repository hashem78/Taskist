import 'package:flutter/material.dart';

abstract class TaskPriority {
  Color color;
  String alert;
  String toString();
  bool operator <(TaskPriority other) {
    if (this.toString() == "high")
      return false;
    else if (this.toString() == "medium") {
      if (other.toString() == "high")
        return true;
      else
        return false;
    } else {
      if (other.toString() == "high" || other.toString() == "medium")
        return true;
      else
        return false;
    }
  }

  bool operator >(TaskPriority other) {
    return other < this;
  }
}

class HighTaskPriority extends TaskPriority {
  HighTaskPriority(String alert) {
    super.color = Colors.redAccent;
    super.alert = alert;
  }
  @override
  String toString() {
    return "high";
  }
}

class MediumTaskPriority extends TaskPriority {
  MediumTaskPriority(String alert) {
    super.color = Colors.amberAccent;
    super.alert = alert;
  }
  @override
  String toString() {
    return "medium";
  }
}

class LowTaskPriority extends TaskPriority {
  LowTaskPriority(String alert) {
    super.color = Colors.greenAccent;
    super.alert = alert;
  }
  @override
  String toString() {
    return "low";
  }
}
