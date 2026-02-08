import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool agreed;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? errorMessage;
  final bool registerSuccess;
  final bool insertUserSuccess;
  final bool showPopup;

  const RegisterState({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.agreed = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.errorMessage,
    this.registerSuccess = false,
    this.insertUserSuccess = false,
    this.showPopup = false,
  });

  RegisterState copyWith({
    String? fullName,
    String? email,
    String? password,
    String? confirmPassword,
    bool? agreed,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
    bool? registerSuccess,
    bool? insertUserSuccess,
    bool? showPopup,
    bool clearError = false,
  }) {
    return RegisterState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      agreed: agreed ?? this.agreed,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      registerSuccess: registerSuccess ?? this.registerSuccess,
      insertUserSuccess: insertUserSuccess ?? this.insertUserSuccess,
      showPopup: showPopup ?? this.showPopup,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
        password,
        confirmPassword,
        agreed,
        isSubmitting,
        isSuccess,
        isFailure,
        errorMessage,
        registerSuccess,
        insertUserSuccess,
        showPopup,
      ];
}
