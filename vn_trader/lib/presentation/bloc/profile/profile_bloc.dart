import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileInitial()) {
    on<ProfilePaymentHistoryPressed>(_onPaymentHistoryPressed);
    on<ProfileSavedPostsPressed>(_onSavedPostsPressed);
    on<ProfileFollowedSignalsPressed>(_onFollowedSignalsPressed);
    on<ProfileSupportCenterPressed>(_onSupportCenterPressed);
    on<ProfileLogoutPressed>(_onLogoutPressed);
  }

  Future<void> _onPaymentHistoryPressed(
    ProfilePaymentHistoryPressed event,
    Emitter<ProfileState> emit,
  ) async {
    _emitAction(ProfileAction.paymentHistory, emit);
  }

  Future<void> _onSavedPostsPressed(
    ProfileSavedPostsPressed event,
    Emitter<ProfileState> emit,
  ) async {
    _emitAction(ProfileAction.savedPosts, emit);
  }

  Future<void> _onFollowedSignalsPressed(
    ProfileFollowedSignalsPressed event,
    Emitter<ProfileState> emit,
  ) async {
    _emitAction(ProfileAction.followedSignals, emit);
  }

  Future<void> _onSupportCenterPressed(
    ProfileSupportCenterPressed event,
    Emitter<ProfileState> emit,
  ) async {
    _emitAction(ProfileAction.supportCenter, emit);
  }

  Future<void> _onLogoutPressed(
    ProfileLogoutPressed event,
    Emitter<ProfileState> emit,
  ) async {
    _emitAction(ProfileAction.logout, emit);
  }

  void _emitAction(ProfileAction action, Emitter<ProfileState> emit) {
    emit(
      state.copyWith(
        lastAction: action,
        actionTick: state.actionTick + 1,
      ),
    );
  }
}
