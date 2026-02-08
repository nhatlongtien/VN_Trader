import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object?> get props => [];
}

class RegisterFullNameChanged extends RegisterEvent {
  final String fullName;
  const RegisterFullNameChanged(this.fullName);
  @override
  List<Object?> get props => [fullName];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;
  const RegisterEmailChanged(this.email);
  @override
  List<Object?> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  const RegisterPasswordChanged(this.password);
  @override
  List<Object?> get props => [password];
}

class RegisterConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;
  const RegisterConfirmPasswordChanged(this.confirmPassword);
  @override
  List<Object?> get props => [confirmPassword];
}

class RegisterTermsToggled extends RegisterEvent {
  final bool agreed;
  const RegisterTermsToggled(this.agreed);
  @override
  List<Object?> get props => [agreed];
}

class RegisterSubmitted extends RegisterEvent {}

class RegisterPopupShown extends RegisterEvent {}

