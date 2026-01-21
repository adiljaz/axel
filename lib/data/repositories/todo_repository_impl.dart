// data/repositories/todo_repository_impl.dart
import 'package:axel/data/datasources/remote/toto_rememote_datasource.dart';
import 'package:axel/domain/repositories/toto_repository.dart';
import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/todo.dart';

import '../datasources/local/todo_local_datasource.dart';


class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;
  final TodoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TodoRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Todo>>> getTodos({int page = 1, int limit = 20}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTodos = await remoteDataSource.getTodos(page: page, limit: limit);
        
        // Merge with cached favorites
        final cachedTodos = await localDataSource.getCachedTodos();
        final mergedTodos = remoteTodos.map((remoteTodo) {
          final cached = cachedTodos.firstWhere(
            (t) => t.id == remoteTodo.id,
            orElse: () => remoteTodo,
          );
          return remoteTodo.copyWith(isFavorite: cached.isFavorite);
        }).toList();
        
        await localDataSource.cacheTodos(mergedTodos);
        return Right(mergedTodos);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final cachedTodos = await localDataSource.getCachedTodos();
        if (cachedTodos.isEmpty) {
          return const Left(NetworkFailure('No internet connection and no cached data'));
        }
        return Right(cachedTodos);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> searchTodos(String query) async {
    try {
      final todos = await localDataSource.getCachedTodos();
      final filtered = todos.where((todo) {
        return todo.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      return Right(filtered);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Todo>> toggleFavorite(int todoId) async {
    try {
      final todo = await localDataSource.toggleFavorite(todoId);
      return Right(todo);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> clearCache() async {
    try {
      await localDataSource.clearCache();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}

