import 'package:flutter/material.dart';

class ColorPalette {
  static const Map<String, Color> colors = {
    'Blue': Colors.blue,
    'Indigo': Colors.indigo,
    'Purple': Colors.purple,
    'Deep Purple': Colors.deepPurple,
    'Pink': Colors.pink,
    'Red': Colors.red,
    'Orange': Colors.orange,
    'Deep Orange': Colors.deepOrange,
    'Green': Colors.green,
    'Teal': Colors.teal,
    'Cyan': Colors.cyan,
    'Amber': Colors.amber,
  };

  static Color getColor(String name) {
    return colors[name] ?? Colors.blue;
  }

  static String getColorName(Color color) {
    for (var entry in colors.entries) {
      if (entry.value == color) {
        return entry.key;
      }
    }
    return 'Blue';
  }

  static List<Map<String, dynamic>> get colorList {
    return colors.entries.map((entry) {
      return {
        'name': entry.key,
        'color': entry.value,
      };
    }).toList();
  }
}