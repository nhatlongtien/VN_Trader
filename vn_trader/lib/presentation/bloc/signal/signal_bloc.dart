import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'signal_event.dart';
part 'signal_state.dart';

class SignalBloc extends Bloc<SignalEvent, SignalState> {
  SignalBloc() : super(const SignalInitial()) {
    on<SignalInitialized>(_onSignalInitialized);
    on<SignalCategoryChanged>(_onSignalCategoryChanged);
  }

  Future<void> _onSignalInitialized(
    SignalInitialized event,
    Emitter<SignalState> emit,
  ) async {
    emit(const SignalInitial());
  }

  Future<void> _onSignalCategoryChanged(
    SignalCategoryChanged event,
    Emitter<SignalState> emit,
  ) async {
    emit(state.copyWith(selectedCategory: event.category));
  }
}
