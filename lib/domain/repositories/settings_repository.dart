
// domain/repositories/settings_repository.dart
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../core/error/failures.dart';
import '../entities/app_settings.dart';

abstract class SettingsRepository {
  Future<Either<Failure, AppSettings>> getSettings();
  Future<Either<Failure, void>> updateTheme(bool isDarkMode, String colorName);
  Future<Either<Failure, void>> clearAllCache();
}