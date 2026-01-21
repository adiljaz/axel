import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos({int page = 1, int limit = 20});
  Future<Either<Failure, List<Todo>>> searchTodos(String query);
  Future<Either<Failure, Todo>> toggleFavorite(int todoId);
  Future<Either<Failure, void>> clearCache();
}
