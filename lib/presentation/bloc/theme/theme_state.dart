// presentation/bloc/theme/theme_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/color_palette.dart';

class ThemeState extends Equatable {
  final bool isDarkMode;
  final String colorName;

  const ThemeState({
    this.isDarkMode = false,
    this.colorName = 'Blue',
  });

  Color get primaryColor => ColorPalette.getColor(colorName);

  ThemeState copyWith({bool? isDarkMode, String? colorName}) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      colorName: colorName ?? this.colorName,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, colorName];
}