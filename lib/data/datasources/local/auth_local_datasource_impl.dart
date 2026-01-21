import '../../../domain/repositories/auth_repository.dart';
import '../../core/services/hive_service.dart';
import '../../domain/entities/user.dart';
import '../../core/error/failures.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveService hiveService;

  AuthLocalDataSourceImpl({required this.hiveService});

  @override
  Future<User> login(String username, String password, bool rememberMe) async {
    try {
      // Check if user already exists and credentials match
      final existingUsers = await hiveService.getUsers();
      final existingUser = existingUsers.firstWhere(
        (user) => user.username == username,
      );
      
      if (existingUser != null) {
        // Validate password
        // In a real app, you'd hash the password and compare
        // For this demo, we'll just check exact match
        if (existingUser.password == password) {
          return existingUser;
        } else {
          throw Exception('Invalid credentials');
        }
      }
      
      // Create new user
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: username,
        fullName: username, // For demo, using username as full name
        password: password,
        dateOfBirth: DateTime.now(),
        createdAt: DateTime.now(),
        rememberMe: rememberMe,
      );
      
      await hiveService.saveUser(newUser);
      return newUser;
    } catch (e) {
      throw CacheFailure('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<User> register(User user) async {
    try {
      // Check if username already exists
      final existingUsers = await hiveService.getUsers();
      final existingUser = existingUsers.firstWhere(
        (user) => user.username == username,
      );
      
      if (existingUser != null) {
        throw Exception('Username already exists');
      }
      
      await hiveService.saveUser(user);
      return user;
    } catch (e) {
      throw CacheFailure('Registration failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await hiveService.clearUser();
    } catch (e) {
      throw CacheFailure('Logout failed: ${e.toString()}');
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final users = await hiveService.getUsers();
      return users.isNotEmpty ? users.first : null;
    } catch (e) {
      throw CacheFailure('Failed to get current user: ${e.toString()}');
    }
  }
}
