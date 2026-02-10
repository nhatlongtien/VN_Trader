part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfilePaymentHistoryPressed extends ProfileEvent {
  const ProfilePaymentHistoryPressed();
}

class ProfileSavedPostsPressed extends ProfileEvent {
  const ProfileSavedPostsPressed();
}

class ProfileFollowedSignalsPressed extends ProfileEvent {
  const ProfileFollowedSignalsPressed();
}

class ProfileSupportCenterPressed extends ProfileEvent {
  const ProfileSupportCenterPressed();
}

class ProfileAdminPanelPressed extends ProfileEvent {
  const ProfileAdminPanelPressed();
}

class ProfileLogoutPressed extends ProfileEvent {
  const ProfileLogoutPressed();
}
