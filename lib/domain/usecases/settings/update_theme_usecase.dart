// domain/usecases/settings/update_theme_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/app_settings.dart';
import '../../repositories/settings_repository.dart';

class UpdateThemeUseCase {
  final SettingsRepository repository;

  UpdateThemeUseCase(this.repository);

  Future<Either<Failure, void>> call(bool isDarkMode, String colorName) async {
    return await repository.updateTheme(isDarkMode, colorName);
  }
}
