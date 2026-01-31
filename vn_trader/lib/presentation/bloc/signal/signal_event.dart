part of 'signal_bloc.dart';

abstract class SignalEvent extends Equatable {
  const SignalEvent();

  @override
  List<Object> get props => [];
}

class SignalCategoryChanged extends SignalEvent {
  final String category;

  const SignalCategoryChanged(this.category);

  @override
  List<Object> get props => [category];
}

class SignalInitialized extends SignalEvent {
  const SignalInitialized();
}
