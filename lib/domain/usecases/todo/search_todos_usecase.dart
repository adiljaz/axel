// domain/usecases/todo/search_todos_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../repositories/todo_repository.dart';
import '../../entities/todo.dart';

class SearchTodosUseCase {
  final TodoRepository repository;
  SearchTodosUseCase(this.repository);

  Future<Either<Failure, List<Todo>>> call(String query) {
    return repository.searchTodos(query);
  }
}