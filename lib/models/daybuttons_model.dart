import 'package:flutter/material.dart';

class DayButtonsModel with ChangeNotifier {
  List<bool> repeates = [false, false, false, false, false, false, false];
  void triggerAtIndex(int index) {
    repeates[index] = !repeates[index];
    notifyListeners();
  }

  bool getAtIndex(int index) {
    return repeates[index];
  }
}
