part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure, validationError }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final String? errorMessage;
  final bool isEmailValid;
  final bool isPasswordValid;

  const LoginState({
    this.email = '',
    this.password = '',
    this.status = LoginStatus.initial,
    this.errorMessage,
    this.isEmailValid = false,
    this.isPasswordValid = false,
  });

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? errorMessage,
    bool? isEmailValid,
    bool? isPasswordValid,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    status,
    errorMessage,
    isEmailValid,
    isPasswordValid,
  ];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}
