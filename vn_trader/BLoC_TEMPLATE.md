# 🔧 BLoC Template Generator

Hướng dẫn nhanh tạo một BLoC mới cho feature.

## 📋 Các bước

### 1. Tạo thư mục cho feature
```bash
mkdir -p lib/presentation/bloc/{feature_name}
```

### 2. Tạo Event class
File: `lib/presentation/bloc/{feature_name}/{feature_name}_event.dart`

```dart
part of '{feature_name}_bloc.dart';

abstract class {FeatureName}Event extends Equatable {
  const {FeatureName}Event();

  @override
  List<Object> get props => [];
}

class {FeatureName}Started extends {FeatureName}Event {
  const {FeatureName}Started();
}

class {FeatureName}Updated extends {FeatureName}Event {
  final String data;

  const {FeatureName}Updated({required this.data});

  @override
  List<Object> get props => [data];
}
```

### 3. Tạo State class
File: `lib/presentation/bloc/{feature_name}/{feature_name}_state.dart`

```dart
part of '{feature_name}_bloc.dart';

abstract class {FeatureName}State extends Equatable {
  const {FeatureName}State();

  @override
  List<Object> get props => [];
}

class {FeatureName}Initial extends {FeatureName}State {
  const {FeatureName}Initial();
}

class {FeatureName}Loading extends {FeatureName}State {
  const {FeatureName}Loading();
}

class {FeatureName}Success extends {FeatureName}State {
  final String data;

  const {FeatureName}Success({required this.data});

  @override
  List<Object> get props => [data];
}

class {FeatureName}Error extends {FeatureName}State {
  final String message;

  const {FeatureName}Error({required this.message});

  @override
  List<Object> get props => [message];
}
```

### 4. Tạo BLoC class
File: `lib/presentation/bloc/{feature_name}/{feature_name}_bloc.dart`

```dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '{feature_name}_event.dart';
part '{feature_name}_state.dart';

class {FeatureName}Bloc extends Bloc<{FeatureName}Event, {FeatureName}State> {
  // TODO: Inject repositories
  
  {FeatureName}Bloc() : super(const {FeatureName}Initial()) {
    on<{FeatureName}Started>(_on{FeatureName}Started);
    on<{FeatureName}Updated>(_on{FeatureName}Updated);
  }

  Future<void> _on{FeatureName}Started(
    {FeatureName}Started event,
    Emitter<{FeatureName}State> emit,
  ) async {
    try {
      emit(const {FeatureName}Loading());
      // TODO: Fetch data from repository
      emit(const {FeatureName}Success(data: 'data'));
    } catch (e) {
      emit({FeatureName}Error(message: e.toString()));
    }
  }

  Future<void> _on{FeatureName}Updated(
    {FeatureName}Updated event,
    Emitter<{FeatureName}State> emit,
  ) async {
    try {
      emit(const {FeatureName}Loading());
      // TODO: Update data in repository
      emit({FeatureName}Success(data: event.data));
    } catch (e) {
      emit({FeatureName}Error(message: e.toString()));
    }
  }
}
```

### 5. Tạo index.dart
File: `lib/presentation/bloc/{feature_name}/index.dart`

```dart
// {FeatureName} BLoC exports
export '{feature_name}_bloc.dart';
export '{feature_name}_event.dart';
export '{feature_name}_state.dart';
```

### 6. Cập nhật presentation bloc index
File: `lib/presentation/bloc/index.dart`

```dart
// ... existing exports ...
export '{feature_name}/index.dart';
```

### 7. Tạo Page
File: `lib/presentation/pages/{feature_name}_page.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_trader/presentation/bloc/index.dart';
import 'package:vn_trader/presentation/widgets/index.dart';

class {FeatureName}Page extends StatelessWidget {
  const {FeatureName}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{FeatureName}'),
      ),
      body: BlocBuilder<{FeatureName}Bloc, {FeatureName}State>(
        builder: (context, state) {
          if (state is {FeatureName}Loading) {
            return const LoadingWidget(message: 'Loading...');
          } else if (state is {FeatureName}Success) {
            return Center(child: Text(state.data));
          } else if (state is {FeatureName}Error) {
            return ErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<{FeatureName}Bloc>().add(
                  const {FeatureName}Started(),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
```

### 8. Tạo Unit Test
File: `test/bloc/{feature_name}_bloc_test.dart`

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vn_trader/presentation/bloc/index.dart';

void main() {
  group('{FeatureName}Bloc', () {
    late {FeatureName}Bloc {featureName}Bloc;

    setUp(() {
      {featureName}Bloc = {FeatureName}Bloc();
    });

    tearDown(() {
      {featureName}Bloc.close();
    });

    test('initial state is {FeatureName}Initial', () {
      expect({featureName}Bloc.state, isA<{FeatureName}Initial>());
    });

    group('{FeatureName}Started', () {
      blocTest<{FeatureName}Bloc, {FeatureName}State>(
        'emits [{FeatureName}Loading, {FeatureName}Success]',
        build: () => {featureName}Bloc,
        act: (bloc) => bloc.add(const {FeatureName}Started()),
        expect: () => [
          isA<{FeatureName}Loading>(),
          isA<{FeatureName}Success>(),
        ],
      );
    });
  });
}
```

## 🎯 Naming Convention

- **Feature name**: lowercase_with_underscores
- **Class name**: PascalCase
- **File name**: lowercase_with_underscores.dart

## ✅ Checklist

- [ ] Tạo thư mục feature
- [ ] Tạo event.dart
- [ ] Tạo state.dart
- [ ] Tạo bloc.dart
- [ ] Tạo index.dart
- [ ] Tạo page.dart
- [ ] Tạo _bloc_test.dart
- [ ] Cập nhật `lib/presentation/bloc/index.dart`
- [ ] Cập nhật `lib/presentation/pages/index.dart`
- [ ] Test page có thể build và navigate

## 📚 Tài liệu

Xem [BLOC_GUIDE.md](./BLOC_GUIDE.md) để hiểu thêm về BLoC pattern.

---

**Pro Tip:** Sử dụng các template này để tạo features mới nhanh chóng! ⚡
