import 'package:amigo_secreto_app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ColorThemeProvider extends ChangeNotifier {
  int _selectedColorTheme = 0;
  final themeColorList = colorList;

  int get selectedColorTheme => _selectedColorTheme;

  void setColorTheme(int index) {
    if (index < 0 || index >= themeColorList.length) {
      throw Exception('Index out of range for color themes');
    }
    _selectedColorTheme = index;
    notifyListeners();
  }
}
