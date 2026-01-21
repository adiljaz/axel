// presentation/bloc/settings/settings_state.dart
import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final dynamic settings;

  SettingsLoaded(this.settings);

  @override
  List<Object?> get props => [settings];
}

class CacheCleared extends SettingsState {}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);

  @override
  List<Object?> get props => [message];
}