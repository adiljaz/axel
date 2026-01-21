// presentation/bloc/profile/profile_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository authRepository;

  ProfileBloc({
    required this.authRepository,
  }) : super(ProfileInitial()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onLoadProfile(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await authRepository.checkAuthentication();
    
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (user) {
        if (user != null) {
          emit(ProfileLoaded(user));
        } else {
          emit(ProfileError('User not found'));
        }
      },
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await authRepository.updateProfile(event.user);
    
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (user) => emit(ProfileUpdated(user)),
    );
  }

  Future<void> loadProfile() async {
    add(LoadProfileEvent());
  }

  Future<void> updateProfile(User user) async {
    add(UpdateProfileEvent(user));
  }
}