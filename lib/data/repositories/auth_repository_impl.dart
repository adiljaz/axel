// data/repositories/auth_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, User>> login(
    String username,
    String password,
    bool rememberMe,
  ) async {
    try {
      final user = await localDataSource.login(username, password, rememberMe);
      return Right(user);
    } on CacheException catch (e) {
      return Left(AuthenticationFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> register(User user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final result = await localDataSource.register(userModel);
      return Right(result);
    } on CacheException catch (e) {
      return Left(ValidationFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.logout();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, User?>> checkAuthentication() async {
    try {
      final user = await localDataSource.getCurrentUser();
      return Right(user);
    } catch (_) {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile(User user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final result = await localDataSource.updateUser(userModel);
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isUsernameTaken(String username) async {
    try {
      final result = await localDataSource.isUsernameTaken(username);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}

