import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterFullNameChanged>((event, emit) {
      emit(state.copyWith(fullName: event.fullName));
    });
    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<RegisterConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });
    on<RegisterTermsToggled>((event, emit) {
      emit(state.copyWith(agreed: event.agreed));
    });
    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false, errorMessage: null));
      // TODO: Add real registration logic here
      await Future.delayed(const Duration(seconds: 1));
      if (state.fullName.isEmpty || state.email.isEmpty || state.password.isEmpty || state.confirmPassword.isEmpty) {
        emit(state.copyWith(isSubmitting: false, isFailure: true, errorMessage: 'Please fill all fields'));
      } else if (state.password != state.confirmPassword) {
        emit(state.copyWith(isSubmitting: false, isFailure: true, errorMessage: 'Passwords do not match'));
      } else if (!state.agreed) {
        emit(state.copyWith(isSubmitting: false, isFailure: true, errorMessage: 'You must agree to the terms'));
      } else {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      }
    });
  }
}
