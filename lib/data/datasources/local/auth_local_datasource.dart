import '../../../core/constants/app_constants.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/services/hive_service.dart';
import '../../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> login(String username, String password, bool rememberMe);
  Future<UserModel> register(UserModel user);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
  Future<UserModel> updateUser(UserModel user);
  Future<bool> isUsernameTaken(String username);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveService hiveService;

  AuthLocalDataSourceImpl({required this.hiveService});

  @override
  Future<UserModel> login(String username, String password, bool rememberMe) async {
    try {
      final users = hiveService.getUsers();
      final user = users.firstWhere(
        (u) => u.username == username,
        orElse: () => throw CacheException('User not found'),
      );

      // Check if account is locked
      if (user.lockoutUntil != null && user.lockoutUntil!.isAfter(DateTime.now())) {
        final remainingTime = user.lockoutUntil!.difference(DateTime.now()).inMinutes;
        throw CacheException(
          'Account locked. Try again in $remainingTime minutes.',
        );
      }

      // Verify password
      if (user.password != password) {
        final failedAttempts = user.failedLoginAttempts + 1;

        if (failedAttempts >= AppConstants.maxLoginAttempts) {
          final lockoutUntil = DateTime.now().add(
            const Duration(minutes: AppConstants.lockoutDurationMinutes),
          );
          final updatedUser = user.copyWith(
            failedLoginAttempts: failedAttempts,
            lockoutUntil: lockoutUntil,
          );
          await _updateUserInList(updatedUser);
          throw CacheException(
            'Account locked due to multiple failed attempts. Try again in ${AppConstants.lockoutDurationMinutes} minutes.',
          );
        } else {
          final updatedUser = user.copyWith(failedLoginAttempts: failedAttempts);
          await _updateUserInList(updatedUser);
          throw CacheException('Invalid password');
        }
      }

      // Reset failed attempts on successful login
      final loggedInUser = user.copyWith(
        failedLoginAttempts: 0,
        lockoutUntil: null,
        rememberMe: rememberMe,
      );

      await _updateUserInList(loggedInUser);
      await hiveService.setCurrentUser(loggedInUser);

      return loggedInUser;
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(e.toString());
    }
  }

  @override
  Future<UserModel> register(UserModel user) async {
    try {
      // Check if username already exists
      if (await isUsernameTaken(user.username)) {
        throw CacheException('Username already taken');
      }

      final users = hiveService.getUsers();
      users.add(user);
      await hiveService.saveUsers(users);
      await hiveService.setCurrentUser(user);

      return user;
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await hiveService.clearAuth();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = hiveService.getCurrentUser();
      if (user == null) return null;

      // Check if remember me is still valid
      if (!user.rememberMe) {
        await logout();
        return null;
      }

      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    try {
      // Update in users list
      await _updateUserInList(user);
      await hiveService.setCurrentUser(user);

      return user;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<bool> isUsernameTaken(String username) async {
    try {
      final users = hiveService.getUsers();
      return users.any((u) => u.username == username);
    } catch (e) {
      return false;
    }
  }

  Future<void> _updateUserInList(UserModel user) async {
    final users = hiveService.getUsers();
    final index = users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      users[index] = user;
      await hiveService.saveUsers(users);
    }
  }
}