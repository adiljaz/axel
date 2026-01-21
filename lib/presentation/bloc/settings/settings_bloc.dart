// presentation/bloc/settings/settings_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/settings/update_theme_usecase.dart';
import '../../../domain/usecases/settings/clear_cache_usecase.dart';
import '../../../domain/repositories/settings_repository.dart';
import 'settings_state.dart';
import 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UpdateThemeUseCase updateThemeUseCase;
  final ClearCacheUseCase clearCacheUseCase;
  final SettingsRepository settingsRepository;

  SettingsBloc({
    required this.updateThemeUseCase,
    required this.clearCacheUseCase,
    required this.settingsRepository,
  }) : super(SettingsInitial()) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<ClearCacheEvent>(_onClearCache);
    on<UpdateSettingsEvent>(_onUpdateSettings);
  }

  Future<void> _onLoadSettings(
    LoadSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());
    final result = await settingsRepository.getSettings();
    
    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (settings) => emit(SettingsLoaded(settings)),
    );
  }

  Future<void> _onClearCache(
    ClearCacheEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());
    final result = await clearCacheUseCase();
    
    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) => emit(CacheCleared()),
    );
  }

  Future<void> _onUpdateSettings(
    UpdateSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());
    final result = await updateThemeUseCase(
      event.settings.isDarkMode,
      event.settings.primaryColorName,
    );
    
    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) => emit(SettingsLoaded(event.settings)),
    );
  }

  Future<void> loadSettings() async {
    add(LoadSettingsEvent());
  }

  Future<void> clearCache() async {
    add(ClearCacheEvent());
  }
}