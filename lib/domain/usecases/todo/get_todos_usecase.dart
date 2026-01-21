// domain/usecases/todo/get_todos_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../repositories/todo_repository.dart';
import '../../entities/todo.dart';

class GetTodosUseCase {
  final TodoRepository repository;
  GetTodosUseCase(this.repository);

  Future<Either<Failure, List<Todo>>> call({int page = 1, int limit = 20}) {
    return repository.getTodos(page: page, limit: limit);
  }
}