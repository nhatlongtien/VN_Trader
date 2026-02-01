part of 'macro_bloc.dart';

abstract class MacroEvent extends Equatable {
  const MacroEvent();

  @override
  List<Object> get props => [];
}

class MacroCategoryChanged extends MacroEvent {
  final String category;

  const MacroCategoryChanged(this.category);

  @override
  List<Object> get props => [category];
}

class MacroInitialized extends MacroEvent {
  const MacroInitialized();
}
