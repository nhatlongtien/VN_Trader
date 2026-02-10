part of 'profile_bloc.dart';

enum ProfileAction {
  none,
  paymentHistory,
  savedPosts,
  followedSignals,
  supportCenter,
  adminPanel,
  logout,
}

class ProfileState extends Equatable {
  final ProfileAction lastAction;
  final int actionTick;

  const ProfileState({
    required this.lastAction,
    required this.actionTick,
  });

  ProfileState copyWith({
    ProfileAction? lastAction,
    int? actionTick,
  }) {
    return ProfileState(
      lastAction: lastAction ?? this.lastAction,
      actionTick: actionTick ?? this.actionTick,
    );
  }

  @override
  List<Object> get props => [lastAction, actionTick];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial() : super(lastAction: ProfileAction.none, actionTick: 0);
}
