import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterInitial()) {
    on<CounterIncrementPressed>(_onCounterIncrementPressed);
    on<CounterDecrementPressed>(_onCounterDecrementPressed);
    on<CounterResetPressed>(_onCounterResetPressed);
  }

  Future<void> _onCounterIncrementPressed(
    CounterIncrementPressed event,
    Emitter<CounterState> emit,
  ) async {
    emit(state.copyWith(count: state.count + 1));
  }

  Future<void> _onCounterDecrementPressed(
    CounterDecrementPressed event,
    Emitter<CounterState> emit,
  ) async {
    emit(state.copyWith(count: state.count - 1));
  }

  Future<void> _onCounterResetPressed(
    CounterResetPressed event,
    Emitter<CounterState> emit,
  ) async {
    emit(const CounterState(count: 0, message: 'Counter reset'));
  }
}
