import '../../../domain/repositories/settings_repository.dart';
import '../../core/services/hive_service.dart';
import '../../domain/entities/app_settings.dart';
import '../../core/error/failures.dart';

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final HiveService hiveService;

  SettingsLocalDataSourceImpl({required this.hiveService});

  @override
  Future<void> saveSettings(AppSettings settings) async {
    try {
      await hiveService.saveSettings(settings);
    } catch (e) {
      throw CacheFailure('Failed to save settings: ${e.toString()}');
    }
  }

  @override
  Future<AppSettings?> getSettings() async {
    try {
      return await hiveService.getSettings();
    } catch (e) {
      throw CacheFailure('Failed to get settings: ${e.toString()}');
    }
  }

  @override
  Future<Either<Failure, void>> clearAllCache() async {
    try {
      await hiveService.clearAllData();
    } catch (e) {
      throw CacheFailure('Failed to clear cache: ${e.toString()}');
    }
  }
}
