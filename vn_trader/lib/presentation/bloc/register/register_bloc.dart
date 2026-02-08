import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_trader/data/repositories/register_account_repository.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterAccountRepository _repository;

  RegisterBloc({RegisterAccountRepository? repository})
      : _repository = repository ?? RegisterAccountRepository(),
        super(const RegisterState()) {
    on<RegisterFullNameChanged>((event, emit) {
      emit(state.copyWith(
        fullName: event.fullName,
        isFailure: false,
        isSuccess: false,
        clearError: true,
      ));
    });
    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(
        email: event.email,
        isFailure: false,
        isSuccess: false,
        clearError: true,
      ));
    });
    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(
        password: event.password,
        isFailure: false,
        isSuccess: false,
        clearError: true,
      ));
    });
    on<RegisterConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(
        confirmPassword: event.confirmPassword,
        isFailure: false,
        isSuccess: false,
        clearError: true,
      ));
    });
    on<RegisterTermsToggled>((event, emit) {
      emit(state.copyWith(
        agreed: event.agreed,
        isFailure: false,
        isSuccess: false,
        clearError: true,
      ));
    });
    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(
        isSubmitting: true,
        isFailure: false,
        isSuccess: false,
        clearError: true,
      ));

      // Validate inputs
      if (state.fullName.isEmpty || state.email.isEmpty || state.password.isEmpty || state.confirmPassword.isEmpty) {
        emit(state.copyWith(isSubmitting: false, isFailure: true, errorMessage: 'Please fill all fields'));
        return;
      }

      if (state.password != state.confirmPassword) {
        emit(state.copyWith(isSubmitting: false, isFailure: true, errorMessage: 'Passwords do not match'));
        return;
      }

      if (!state.agreed) {
        emit(state.copyWith(isSubmitting: false, isFailure: true, errorMessage: 'You must agree to the terms'));
        return;
      }

      // Email validation
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
      if (!emailRegex.hasMatch(state.email)) {
        emit(state.copyWith(isSubmitting: false, isFailure: true, errorMessage: 'Invalid email format'));
        return;
      }

      // Password strength validation
      if (state.password.length < 6) {
        emit(state.copyWith(isSubmitting: false, isFailure: true, errorMessage: 'Password must be at least 6 characters'));
        return;
      }

      try {
        // Call repository to register user
        await _repository.registerWithEmail(
          state.email,
          state.password,
          state.fullName,
        );

        emit(state.copyWith(isSubmitting: false, isSuccess: true));

      } catch (e) {
        emit(state.copyWith(
          isSubmitting: false,
          isFailure: true,
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ));
      }
    });
  }
}
