part of 'macro_bloc.dart';

class MacroState extends Equatable {
  final String selectedCategory;

  const MacroState({
    required this.selectedCategory,
  });

  MacroState copyWith({
    String? selectedCategory,
  }) {
    return MacroState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object> get props => [selectedCategory];
}

class MacroInitial extends MacroState {
  const MacroInitial() : super(selectedCategory: 'All');
}