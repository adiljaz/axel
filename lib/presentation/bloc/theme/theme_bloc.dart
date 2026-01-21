// presentation/bloc/theme/theme_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/settings_repository.dart';
import '../../../domain/entities/app_settings.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SettingsRepository settingsRepository;

  ThemeBloc({
    required this.settingsRepository,
  }) : super(const ThemeState()) {
    on<ToggleThemeEvent>(_onToggleTheme);
    on<ChangeColorEvent>(_onChangeColor);
    on<LoadThemeEvent>(_onLoadTheme);
  }

  Future<void> _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final currentState = state;
    final updatedState = currentState.copyWith(isDarkMode: event.isDarkMode);
    emit(updatedState);
    
    await settingsRepository.updateTheme(
      updatedState.isDarkMode,
      updatedState.colorName,
    );
  }

  Future<void> _onChangeColor(
    ChangeColorEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final currentState = state;
    final updatedState = currentState.copyWith(colorName: event.colorName);
    emit(updatedState);
    
    await settingsRepository.updateTheme(
      updatedState.isDarkMode,
      updatedState.colorName,
    );
  }

  Future<void> _onLoadTheme(
    LoadThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final result = await settingsRepository.getSettings();
    
    result.fold(
      (failure) => emit(const ThemeState()),
      (settings) => emit(ThemeState(
        isDarkMode: settings.isDarkMode,
        colorName: settings.primaryColorName,
      )),
    );
  }

  Future<void> loadTheme() async {
    add(LoadThemeEvent());
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    add(ToggleThemeEvent(isDarkMode));
  }

  Future<void> changeColor(String colorName) async {
    add(ChangeColorEvent(colorName));
  }
}