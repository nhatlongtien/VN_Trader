# VN Trader - BLoC Architecture Guide

## 📁 Cấu Trúc Dự Án

```
lib/
├── core/                    # Tầng Core - Các tiện ích chung
│   ├── constants/          # Hằng số ứng dụng
│   ├── theme/              # Chủ đề, style
│   ├── utils/              # Các hàm tiện ích
│   └── service_locator.dart # Dependency Injection
│
├── data/                    # Tầng Data - Xử lý dữ liệu
│   ├── datasources/        # Nguồn dữ liệu (API, Database)
│   ├── models/             # Dữ liệu model (JSON serialization)
│   └── repositories/       # Triển khai Repository
│
├── domain/                  # Tầng Domain - Logic nghiệp vụ
│   ├── entities/           # Đối tượng miền (Plain objects)
│   ├── repositories/       # Interface Repository
│   └── usecases/           # Use cases / Business logic
│
├── presentation/           # Tầng Presentation - UI
│   ├── bloc/              # BLoC state management
│   │   ├── counter/       # Counter BLoC example
│   │   │   ├── counter_bloc.dart
│   │   │   ├── counter_event.dart
│   │   │   ├── counter_state.dart
│   │   │   └── index.dart
│   │   └── index.dart
│   ├── pages/             # Trang chính
│   ├── widgets/           # Widgets tái sử dụng
│   └── theme/             # Chủ đề cụ thể UI
│
└── main.dart              # Entry point
```

## 🏗️ BLoC Pattern

### Cấu trúc một BLoC hoàn chỉnh:

```
lib/presentation/bloc/counter/
├── counter_bloc.dart      # BLoC logic
├── counter_event.dart     # Events
├── counter_state.dart     # States
└── index.dart            # Exports
```

### Counter Event (counter_event.dart)
```dart
part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class CounterIncrementPressed extends CounterEvent {
  const CounterIncrementPressed();
}
```

### Counter State (counter_state.dart)
```dart
part of 'counter_bloc.dart';

class CounterState extends Equatable {
  final int count;
  final String message;

  const CounterState({
    required this.count,
    this.message = '',
  });

  @override
  List<Object> get props => [count, message];
}
```

### Counter BLoC (counter_bloc.dart)
```dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterInitial()) {
    on<CounterIncrementPressed>(_onCounterIncrementPressed);
  }

  Future<void> _onCounterIncrementPressed(
    CounterIncrementPressed event,
    Emitter<CounterState> emit,
  ) async {
    emit(state.copyWith(count: state.count + 1));
  }
}
```

## 📝 Cách sử dụng BLoC trong Widget

### 1. Cung cấp BLoC (Provider)
```dart
BlocProvider(
  create: (context) => CounterBloc(),
  child: HomePage(),
)
```

### 2. Lắng nghe State (Builder)
```dart
BlocBuilder<CounterBloc, CounterState>(
  builder: (context, state) {
    return Text('Count: ${state.count}');
  },
)
```

### 3. Phát hành Event (Read)
```dart
context.read<CounterBloc>().add(const CounterIncrementPressed());
```

### 4. Kết hợp Provider và Builder
```dart
BlocListener<CounterBloc, CounterState>(
  listener: (context, state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.message)),
    );
  },
  child: BlocBuilder<CounterBloc, CounterState>(
    builder: (context, state) {
      return Text('Count: ${state.count}');
    },
  ),
)
```

## 🔄 Clean Architecture Layers

### Domain Layer (lib/domain/)
- **Entities**: Đối tượng dữ liệu pure, không phụ thuộc vào framework
- **Repositories (Abstract)**: Hợp đồng cho data layer
- **UseCases**: Logic nghiệp vụ, không phụ thuộc vào UI

### Data Layer (lib/data/)
- **Models**: Mở rộng entities với serialization
- **DataSources**: Truy xuất dữ liệu (API, DB, etc.)
- **Repositories (Implementation)**: Triển khai interface từ domain

### Presentation Layer (lib/presentation/)
- **BLoCs**: State management, xử lý events
- **Pages**: Màn hình chính
- **Widgets**: Các thành phần tái sử dụng

### Core Layer (lib/core/)
- **Constants**: Hằng số ứng dụng
- **Utils**: Hàm tiện ích
- **Theme**: Styling

## ✅ Best Practices

1. **Separation of Concerns**: Mỗi lớp có trách nhiệm riêng
2. **Dependency Injection**: Sử dụng ServiceLocator hoặc package get_it
3. **Immutability**: States và Events nên là bất biến
4. **Equatable**: Sử dụng để so sánh objects
5. **Error Handling**: Xử lý lỗi một cách nhất quán

## 📚 Tài liệu tham khảo

- [BLoC Library](https://bloclibrary.dev/)
- [Flutter BLoC Package](https://pub.dev/packages/flutter_bloc)
- [Clean Architecture](https://resocoder.com/flutter-clean-architecture)

## 🚀 Tạo BLoC mới

Để tạo BLoC mới, làm theo các bước:

1. Tạo thư mục: `lib/presentation/bloc/my_feature/`
2. Tạo 3 file chính:
   - `my_feature_event.dart`
   - `my_feature_state.dart`
   - `my_feature_bloc.dart`
3. Tạo `index.dart` để export
4. Cập nhật `lib/presentation/bloc/index.dart`

## 💡 Ví dụ: Tạo BLoC cho Login

```dart
// lib/presentation/bloc/login/login_event.dart
part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

// lib/presentation/bloc/login/login_state.dart
part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final String message;

  const LoginSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}

// lib/presentation/bloc/login/login_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    
    try {
      // Gọi use case hoặc repository
      await _loginUseCase(event.email, event.password);
      emit(const LoginSuccess(message: 'Login successful'));
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  Future<void> _loginUseCase(String email, String password) async {
    // Implement login logic
  }
}
```

---

**Chúc bạn code vui vẻ! Happy coding! 🎉**
