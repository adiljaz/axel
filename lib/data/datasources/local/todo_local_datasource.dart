import '../../../core/error/exceptions.dart';
import '../../../core/services/hive_service.dart';
import '../../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getCachedTodos();
  Future<void> cacheTodos(List<TodoModel> todos);
  Future<TodoModel> toggleFavorite(int todoId);
  Future<void> clearCache();
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final HiveService hiveService;

  TodoLocalDataSourceImpl({required this.hiveService});

  @override
  Future<List<TodoModel>> getCachedTodos() async {
    try {
      return hiveService.getTodos();
    } catch (e) {
      throw CacheException('Failed to load cached todos: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheTodos(List<TodoModel> todos) async {
    try {
      await hiveService.saveTodos(todos);
    } catch (e) {
      throw CacheException('Failed to cache todos: ${e.toString()}');
    }
  }

  @override
  Future<TodoModel> toggleFavorite(int todoId) async {
    try {
      final todos = await getCachedTodos();
      
      final index = todos.indexWhere((todo) => todo.id == todoId);
      
      if (index == -1) {
        throw CacheException('Todo not found');
      }
      
      final updatedTodo = todos[index].copyWith(
        isFavorite: !todos[index].isFavorite,
      );
      
      todos[index] = updatedTodo;
      
      await cacheTodos(todos);
      
      return updatedTodo;
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException('Failed to toggle favorite: ${e.toString()}');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await hiveService.saveTodos(const <TodoModel>[]);
    } catch (e) {
      throw CacheException('Failed to clear cache: ${e.toString()}');
    }
  }
}