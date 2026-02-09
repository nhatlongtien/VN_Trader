import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vn_trader/domain/repositories/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _repository = LoginRepository();
  LoginBloc() : super(const LoginInitial()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
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
    if (!state.isEmailValid) {
      emit(state.copyWith(
        status: LoginStatus.validationError,
        errorMessage: 'Please enter a valid email',
      ));
      return;
    }
    if (!state.isPasswordValid) {
      emit(state.copyWith(
        status: LoginStatus.validationError,
        errorMessage: 'Please enter a valid password',
      ));
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    try {
      // TODO: Implement actual login logic with repository
      final response = await _repository.loginWithEmailPassword(
        email: state.email,
        password: state.password,
      );
      
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
    return regex.hasMatch(email);
  }

  /// Validate password
  bool _isValidPassword(String password) {
    return password.length >= 6;
  }
}
