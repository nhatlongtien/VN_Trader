/// Counter BLoC tests
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vn_trader/presentation/bloc/counter/counter_bloc.dart';

void main() {
  group('CounterBloc', () {
    late CounterBloc counterBloc;

    setUp(() {
      counterBloc = CounterBloc();
    });

    tearDown(() {
      counterBloc.close();
    });

    test('initial state is CounterInitial', () {
      expect(counterBloc.state, isA<CounterInitial>());
    });

    group('CounterIncrementPressed', () {
      blocTest<CounterBloc, CounterState>(
        'emits [CounterState(count: 1)] when CounterIncrementPressed is added',
        build: () => counterBloc,
        act: (bloc) => bloc.add(const CounterIncrementPressed()),
        expect: () => [
          isA<CounterState>()
              .having((state) => state.count, 'count', 1)
              .having((state) => state.message, 'message', ''),
        ],
      );

      blocTest<CounterBloc, CounterState>(
        'emits [CounterState(count: 2)] when CounterIncrementPressed is added twice',
        build: () => counterBloc,
        act: (bloc) {
          bloc.add(const CounterIncrementPressed());
          bloc.add(const CounterIncrementPressed());
        },
        expect: () => [
          isA<CounterState>().having((state) => state.count, 'count', 1),
          isA<CounterState>().having((state) => state.count, 'count', 2),
        ],
      );
    });

    group('CounterDecrementPressed', () {
      blocTest<CounterBloc, CounterState>(
        'emits [CounterState(count: -1)] when CounterDecrementPressed is added',
        build: () => counterBloc,
        act: (bloc) => bloc.add(const CounterDecrementPressed()),
        expect: () => [
          isA<CounterState>()
              .having((state) => state.count, 'count', -1)
              .having((state) => state.message, 'message', ''),
        ],
      );
    });

    group('CounterResetPressed', () {
      blocTest<CounterBloc, CounterState>(
        'emits [CounterState(count: 0, message: "Counter reset")]',
        build: () => counterBloc,
        act: (bloc) => bloc.add(const CounterResetPressed()),
        expect: () => [
          isA<CounterState>()
              .having((state) => state.count, 'count', 0)
              .having((state) => state.message, 'message', 'Counter reset'),
        ],
      );
    });
  });
}
