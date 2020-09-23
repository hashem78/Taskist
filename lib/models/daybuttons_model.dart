import 'package:flutter/material.dart';

class DayButtonsModel with ChangeNotifier {
  List<bool> repeates = [false, false, false, false, false, false, false];
  void triggerAtIndex(int index) {
    repeates[index] = !repeates[index];
    notifyListeners();
  }

  void clear() {
    for (int i = 0; i < 7; ++i) repeates[i] = false;
  }

  bool getAtIndex(int index) {
    return repeates[index];
  }
}
