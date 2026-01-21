import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../../../core/error/exceptions.dart';
import '../../models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos({int page = 1, int limit = 20});
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final http.Client client;

  TodoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TodoModel>> getTodos({int page = 1, int limit = 20}) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.todosEndpoint}'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        
        // Apply pagination
        final startIndex = (page - 1) * limit;
        final endIndex = startIndex + limit;
        
        final paginatedList = jsonList.sublist(
          startIndex,
          endIndex > jsonList.length ? jsonList.length : endIndex,
        );
        
        return paginatedList.map((json) => TodoModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load todos: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error: ${e.toString()}');
    }
  }
}