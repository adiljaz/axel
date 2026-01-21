// domain/usecases/settings/clear_cache_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../repositories/settings_repository.dart';

class ClearCacheUseCase {
  final SettingsRepository repository;
  ClearCacheUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.clearAllCache();
  }
}