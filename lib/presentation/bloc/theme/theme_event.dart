import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {
  final bool isDarkMode;

  const ToggleThemeEvent(this.isDarkMode);

  @override
  List<Object?> get props => [isDarkMode];
}

class ChangeColorEvent extends ThemeEvent {
  final String colorName;

  const ChangeColorEvent(this.colorName);

  @override
  List<Object?> get props => [colorName];
}

class LoadThemeEvent extends ThemeEvent {}
