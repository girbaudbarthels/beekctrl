import 'package:flutter/material.dart';

class PanelBloc extends ChangeNotifier {
  double sizeAnim = 0;
  setHeight(size, confidence, index) {
    if (index == 0) {
      sizeAnim = (size * 2) * confidence;
      notifyListeners();
    } else {
      sizeAnim = (size * 15) * confidence;
      notifyListeners();
    }
    notifyListeners();
  }
}
