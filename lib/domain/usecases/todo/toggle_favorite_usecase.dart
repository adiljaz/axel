// domain/usecases/todo/toggle_favorite_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../repositories/todo_repository.dart';
import '../../entities/todo.dart';

class ToggleFavoriteUseCase {
  final TodoRepository repository;
  ToggleFavoriteUseCase(this.repository);

  Future<Either<Failure, Todo>> call(int todoId) {
    return repository.toggleFavorite(todoId);
  }
}
