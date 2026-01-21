import '../../../core/error/exceptions.dart';
import '../../../core/services/hive_service.dart';
import '../../models/settings_model.dart';

abstract class SettingsLocalDataSource {
  Future<SettingsModel> getSettings();
  Future<void> saveSettings(SettingsModel settings);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final HiveService hiveService;

  SettingsLocalDataSourceImpl({required this.hiveService});

  @override
  Future<SettingsModel> getSettings() async {
    try {
      return hiveService.getSettings();
    } catch (e) {
      throw CacheException('Failed to load settings: ${e.toString()}');
    }
  }

  @override
  Future<void> saveSettings(SettingsModel settings) async {
    try {
      await hiveService.saveSettings(settings);
    } catch (e) {
      throw CacheException('Failed to save settings: ${e.toString()}');
    }
  }
}