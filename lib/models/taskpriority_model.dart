import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TaskPriorityPredicate extends Equatable {
  final Color color;
  TaskPriorityPredicate({
    this.color,
  });

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

  @override
  List<Object> get props => [color, toString()];
}

class HighTaskPriorityPredicate extends TaskPriorityPredicate {
  HighTaskPriorityPredicate()
      : super(
          color: Colors.redAccent,
        );
  @override
  String toString() {
    return "high";
  }

  @override
  List<Object> get props => super.props;
}

class MediumTaskPriorityPredicate extends TaskPriorityPredicate {
  MediumTaskPriorityPredicate() : super(color: Colors.amberAccent);
  @override
  String toString() {
    return "medium";
  }
}

class LowTaskPriorityPredicate extends TaskPriorityPredicate {
  LowTaskPriorityPredicate()
      : super(
          color: Colors.greenAccent,
        );
  @override
  String toString() {
    return "low";
  }
}

class NoPriorityPredicate extends TaskPriorityPredicate {
  NoPriorityPredicate({String alert})
      : super(
          color: Colors.grey,
        );
  @override
  String toString() {
    return "no";
  }
}
