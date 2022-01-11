import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;
  bool dark = false;
  Color colorBg = Color.fromRGBO(255, 224, 102, 1);
  Color colorMain = Color.fromRGBO(55, 150, 213, 1);
  Color colorMainDark = Color.fromRGBO(45, 130, 186, 1);
  Color colorSec = Color.fromRGBO(70, 167, 120, 1);
  Color colorSecDark = Color.fromRGBO(55, 134, 96, 1);
  Color colorRed = Color.fromRGBO(241, 84, 81, 1);
  BorderRadius border = BorderRadius.circular(12);
  BorderRadius borderTop = BorderRadius.only(
      topRight: Radius.circular(12), topLeft: Radius.circular(12));
  ThemeChanger(this._themeData);

  final PanelController panCtrl = new PanelController();

  double size = 0.0;

  getTheme() => _themeData;

  setTheme(ThemeData theme) {
    _themeData = theme;
    dark = !dark;

    notifyListeners();
  }
}
