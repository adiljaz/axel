// data/repositories/settings_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/local/settings_local_datasource.dart';
import '../datasources/local/todo_local_datasource.dart';
import '../datasources/local/hive_service.dart';
import '../models/settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, AppSettings>> getSettings() async {
    try {
      final settings = await localDataSource.getSettings();
      return Right(settings);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateTheme(bool isDarkMode, String colorName) async {
    try {
      final currentSettings = await localDataSource.getSettings();
      final updatedSettings = currentSettings.copyWith(
        isDarkMode: isDarkMode,
        primaryColorName: colorName,
      );
      await localDataSource.saveSettings(updatedSettings);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> clearAllCache() async {
    try {
      final hiveService = HiveService();
      await hiveService.clearAllData();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}