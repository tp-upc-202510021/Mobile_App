import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/features/profile/data/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit(this.repository) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await repository.getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError('Error loading profile: $e'));
    }
  }
}
