import 'package:flutter/material.dart';

abstract class TaskPriorityPredicate {
  Color color;

  static String stringRep;
  String toString();
  bool operator <(TaskPriorityPredicate other) {
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

  bool operator >(TaskPriorityPredicate other) {
    return other < this;
  }
}

class HighTaskPriorityPredicate extends TaskPriorityPredicate {
  HighTaskPriorityPredicate({String alert}) {
    super.color = Colors.redAccent;
  }
  @override
  String toString() {
    return "high";
  }
}

class MediumTaskPriorityPredicate extends TaskPriorityPredicate {
  MediumTaskPriorityPredicate({String alert}) {
    super.color = Colors.amberAccent;
  }
  @override
  String toString() {
    return "medium";
  }
}

class LowTaskPriorityPredicate extends TaskPriorityPredicate {
  LowTaskPriorityPredicate({String alert}) {
    super.color = Colors.greenAccent;
  }
  @override
  String toString() {
    return "low";
  }
}
