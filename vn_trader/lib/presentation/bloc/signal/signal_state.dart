part of 'signal_bloc.dart';

class SignalState extends Equatable {
  final String selectedCategory;

  const SignalState({
    required this.selectedCategory,
  });

  SignalState copyWith({
    String? selectedCategory,
  }) {
    return SignalState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object> get props => [selectedCategory];
}

class SignalInitial extends SignalState {
  const SignalInitial() : super(selectedCategory: 'All');
}
