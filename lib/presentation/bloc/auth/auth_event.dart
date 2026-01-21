import 'package:equatable/equatable.dart';
import '../../../domain/entities/user.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  final bool rememberMe;

  const LoginEvent({
    required this.username,
    required this.password,
    this.rememberMe = false,
  });

  @override
  List<Object> get props => [username, password, rememberMe];
}

class RegisterEvent extends AuthEvent {
  final User user;

  const RegisterEvent(this.user);

  @override
  List<Object> get props => [user];
}

class LogoutEvent extends AuthEvent {}

class CheckAuthEvent extends AuthEvent {}
