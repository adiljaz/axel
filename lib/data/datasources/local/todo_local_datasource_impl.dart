import '../../../domain/repositories/todo_repository.dart';
import '../../core/services/hive_service.dart';
import '../../domain/entities/todo.dart';
import '../../core/error/failures.dart';

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final HiveService hiveService;

  TodoLocalDataSourceImpl({required this.hiveService});

  @override
  Future<void> saveTodos(List<Todo> todos) async {
    try {
      await hiveService.saveTodos(todos);
    } catch (e) {
      throw CacheFailure('Failed to save todos: ${e.toString()}');
    }
  }

  @override
  Future<List<Todo>> getTodos() async {
    try {
      return await hiveService.getTodos();
    } catch (e) {
      throw CacheFailure('Failed to get todos: ${e.toString()}');
    }
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    try {
      final todos = await hiveService.getTodos();
      final todoIndex = todos.indexWhere((t) => t.id == todo.id);
      
      if (todoIndex != -1) {
        final updatedTodos = List<Todo>.from(todos);
        updatedTodos[todoIndex] = todo;
        await hiveService.saveTodos(updatedTodos);
      }
    } catch (e) {
      throw CacheFailure('Failed to save todo: ${e.toString()}');
    }
  }
}
