import 'package:flutter/material.dart';
import '../../domain/entities/app_settings.dart';
import '../../core/theme/color_palette.dart';

class SettingsModel extends AppSettings {
  const SettingsModel({
    super.isDarkMode,
    super.primaryColorName,
  });

  Color get primaryColor => ColorPalette.getColor(primaryColorName);

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      isDarkMode: json['isDarkMode'] as bool? ?? false,
      primaryColorName: json['primaryColorName'] as String? ?? 'Blue',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'primaryColorName': primaryColorName,
    };
  }

  SettingsModel copyWith({
    bool? isDarkMode,
    String? primaryColorName,
  }) {
    return SettingsModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      primaryColorName: primaryColorName ?? this.primaryColorName,
    );
  }

  factory SettingsModel.fromEntity(AppSettings settings) {
    return SettingsModel(
      isDarkMode: settings.isDarkMode,
      primaryColorName: settings.primaryColorName,
    );
  }

  static SettingsModel get defaultSettings => const SettingsModel(
        isDarkMode: false,
        primaryColorName: 'Blue',
      );
}