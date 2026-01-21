import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.fullName,
    required super.password,
    super.profilePicturePath,
    super.dateOfBirth,
    super.rememberMe,
    super.failedLoginAttempts,
    super.lockoutUntil,
  });

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      fullName: user.fullName,
      password: user.password,
      profilePicturePath: user.profilePicturePath,
      dateOfBirth: user.dateOfBirth,
      rememberMe: user.rememberMe,
      failedLoginAttempts: user.failedLoginAttempts,
      lockoutUntil: user.lockoutUntil,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      password: json['password'] as String,
      profilePicturePath: json['profilePicturePath'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'] as String)
          : null,
      rememberMe: json['rememberMe'] as bool? ?? false,
      failedLoginAttempts: json['failedLoginAttempts'] as int? ?? 0,
      lockoutUntil: json['lockoutUntil'] != null
          ? DateTime.parse(json['lockoutUntil'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'fullName': fullName,
      'password': password,
      'profilePicturePath': profilePicturePath,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'rememberMe': rememberMe,
      'failedLoginAttempts': failedLoginAttempts,
      'lockoutUntil': lockoutUntil?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? fullName,
    String? password,
    String? profilePicturePath,
    DateTime? dateOfBirth,
    bool? rememberMe,
    int? failedLoginAttempts,
    DateTime? lockoutUntil,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      profilePicturePath: profilePicturePath ?? this.profilePicturePath,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      rememberMe: rememberMe ?? this.rememberMe,
      failedLoginAttempts: failedLoginAttempts ?? this.failedLoginAttempts,
      lockoutUntil: lockoutUntil ?? this.lockoutUntil,
    );
  }

  double get profileCompleteness {
    int completed = 0;
    int total = 4;
    
    if (username.isNotEmpty) completed++;
    if (fullName.isNotEmpty) completed++;
    if (profilePicturePath != null && profilePicturePath!.isNotEmpty) completed++;
    if (dateOfBirth != null) completed++;
    
    return (completed / total) * 100;
  }
}