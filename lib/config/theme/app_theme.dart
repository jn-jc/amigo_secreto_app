import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.purple,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.orange,
  Colors.teal,
  Colors.pink,
];

class AppTheme {

  final int selectedColorTheme;

  AppTheme({
    this.selectedColorTheme = 0,
  }):assert(
    selectedColorTheme >= 0 && selectedColorTheme < colorList.length,
    'selectedColorTheme must be between 0 and ${colorList.length - 1}',
  );

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colorList[selectedColorTheme],
  );
}