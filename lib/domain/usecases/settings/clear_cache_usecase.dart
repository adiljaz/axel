import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../repositories/settings_repository.dart';

class ClearCacheUseCase {
  final SettingsRepository repository;

  ClearCacheUseCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.clearAllCache();
  }
}
