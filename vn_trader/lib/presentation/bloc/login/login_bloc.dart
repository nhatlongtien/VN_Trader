import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginWithGooglePressed>(_onLoginWithGoogle);
    on<LoginWithApplePressed>(_onLoginWithApple);
    on<LoginReset>(_onLoginReset);
  }

  Future<void> _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) async {
    final isValid = _isValidEmail(event.email);
    emit(state.copyWith(
      email: event.email,
      isEmailValid: isValid,
      status: LoginStatus.initial,
      errorMessage: null,
    ));
  }

  Future<void> _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
    final isValid = _isValidPassword(event.password);
    emit(state.copyWith(
      password: event.password,
      isPasswordValid: isValid,
      status: LoginStatus.initial,
      errorMessage: null,
    ));
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isFormValid) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Please enter valid email and password',
      ));
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    try {
      // TODO: Implement actual login logic with repository
      await Future.delayed(const Duration(seconds: 2));
      
      emit(state.copyWith(
        status: LoginStatus.success,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoginWithGoogle(
    LoginWithGooglePressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      // TODO: Implement Google login logic
      await Future.delayed(const Duration(seconds: 2));
      
      emit(state.copyWith(
        status: LoginStatus.success,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoginWithApple(
    LoginWithApplePressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      // TODO: Implement Apple login logic
      await Future.delayed(const Duration(seconds: 2));
      
      emit(state.copyWith(
        status: LoginStatus.success,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoginReset(
    LoginReset event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginInitial());
  }

  /// Validate email format
  bool _isValidEmail(String email) {
    if (email.isEmpty) return false;
    const emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(emailRegex);
    return regex.hasMatch(email) || _isValidUsername(email);
  }

  /// Validate username
  bool _isValidUsername(String username) {
    if (username.isEmpty) return false;
    return username.length >= 3;
  }

  /// Validate password
  bool _isValidPassword(String password) {
    return password.length >= 6;
  }
}
