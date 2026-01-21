// domain/entities/user.dart
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String fullName;
  final String password;
  final String? profilePicturePath;
  final DateTime? dateOfBirth;
  final bool rememberMe;
  final int failedLoginAttempts;
  final DateTime? lockoutUntil;

  const User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.password,
    this.profilePicturePath,
    this.dateOfBirth,
    this.rememberMe = false,
    this.failedLoginAttempts = 0,
    this.lockoutUntil,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        fullName,
        password,
        profilePicturePath,
        dateOfBirth,
        rememberMe,
        failedLoginAttempts,
        lockoutUntil,
      ];
}

// domain/entities/todo.dart
class Todo extends Equatable {
  final int id;
  final int userId;
  final String title;
  final bool completed;
  final bool isFavorite;

  const Todo({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [id, userId, title, completed, isFavorite];
}

// domain/entities/app_settings.dart
class AppSettings extends Equatable {
  final bool isDarkMode;
  final String primaryColorName;

  const AppSettings({
    this.isDarkMode = false,
    this.primaryColorName = 'Blue',
  });

  @override
  List<Object?> get props => [isDarkMode, primaryColorName];
}