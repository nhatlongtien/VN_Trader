part of 'counter_bloc.dart';

class CounterState extends Equatable {
  final int count;
  final String message;

  const CounterState({
    required this.count,
    this.message = '',
  });

  CounterState copyWith({
    int? count,
    String? message,
  }) {
    return CounterState(
      count: count ?? this.count,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [count, message];
}

class CounterInitial extends CounterState {
  const CounterInitial() : super(count: 0);
}
