// domain/repositories/auth_repository.dart
import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String username, String password, bool rememberMe);
  Future<Either<Failure, User>> register(User user);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User?>> checkAuthentication();
  Future<Either<Failure, User>> updateProfile(User user);
  Future<Either<Failure, bool>> isUsernameTaken(String username);
}
