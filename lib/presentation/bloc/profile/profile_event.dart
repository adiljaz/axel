import 'package:equatable/equatable.dart';
import '../../../domain/entities/user.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final User user;

  const UpdateProfileEvent(this.user);

  @override
  List<Object?> get props => [user];
}
