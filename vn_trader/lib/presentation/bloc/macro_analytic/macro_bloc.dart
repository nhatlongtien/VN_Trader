import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'macro_event.dart';
part 'macro_state.dart';

class MacroBloc extends Bloc<MacroEvent, MacroState> {
  MacroBloc() : super(const MacroInitial()) {
    on<MacroInitialized>(_onMacroInitialized);
    on<MacroCategoryChanged>(_onMacroCategoryChanged);
  }

  Future<void> _onMacroInitialized(
    MacroInitialized event,
    Emitter<MacroState> emit,
  ) async {
    emit(const MacroInitial());
  }

  Future<void> _onMacroCategoryChanged(
    MacroCategoryChanged event,
    Emitter<MacroState> emit,
  ) async {
    emit(state.copyWith(selectedCategory: event.category));
  }
}