import 'package:flutter/material.dart';

final colorList = <Map<String, dynamic>>[
  {
    'colorName': 'Morado',
    'color': Colors.purple
  },
  {
    'colorName': 'Rojo',
    'color': Colors.red
  },
  {
    'colorName': 'Verde',
    'color': Colors.green
  },
  {
    'colorName': 'Azul',
    'color': Colors.blue
  },
  {
    'colorName': 'Naranja',
    'color': Colors.orange
  },
  {
    'colorName': 'Cian',
    'color': Colors.teal
  },
  {
    'colorName': 'Rosa',
    'color': Colors.pink
  },
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
    colorSchemeSeed: colorList[selectedColorTheme]['color'] as Color,
  );
}