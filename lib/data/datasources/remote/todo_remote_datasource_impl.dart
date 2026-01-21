import 'package:dio/dio.dart';
import '../../../domain/entities/todo.dart';
import '../../../core/error/failures.dart';

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final Dio dio;

  TodoRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<Todo>> getTodos({int page = 1, int limit = 20}) async {
    try {
      final response = await dio.get(
        'https://jsonplaceholder.typicode.com/todos',
        queryParameters: {'_limit': limit.toString(), '_page': page.toString()},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> todosJson = response.data;
        final todos = todosJson.map((json) => Todo(
          id: json['id'],
          userId: json['userId'],
          title: json['title'],
          completed: json['completed'],
          isFavorite: false,
        )).toList();
        
        return Right(todos);
      } else {
        throw ServerFailure('Failed to load todos: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerFailure('Network error: ${e.message}');
    }
  }
}
