// domain/entities/app_settings.dart
import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  final bool isDarkMode;
  final String primaryColorName;

  const AppSettings({
    this.isDarkMode = false,
    this.primaryColorName = 'Blue',
  });

  @override
  List<Object?> get props => [isDarkMode, primaryColorName];
}
