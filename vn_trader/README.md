# VN Trader - Flutter BLoC Architecture

A professional Flutter trading application built with **BLoC Pattern** and **Clean Architecture**.

## 📚 Documentation

- **[SETUP.md](./SETUP.md)** - Setup guide và cấu trúc dự án
- **[BLOC_GUIDE.md](./BLOC_GUIDE.md)** - Chi tiết BLoC pattern và cách sử dụng

## 🏗️ Architecture Overview

Dự án sử dụng **Clean Architecture** với 4 tầng chính:

### 1. **Core Layer** (`lib/core/`)
Chứa các tiện ích chung cho toàn bộ ứng dụng:
- **Constants**: Hằng số ứng dụng, màu sắc
- **Theme**: Cấu hình theme sáng/tối
- **Utils**: Hàm tiện ích, exception handling, logger
- **Service Locator**: Dependency injection

### 2. **Domain Layer** (`lib/domain/`)
Tầng business logic, độc lập với framework:
- **Entities**: Các object dữ liệu pure
- **Repositories (Abstract)**: Interface cho data layer
- **UseCases**: Business logic, xử lý logic nghiệp vụ

### 3. **Data Layer** (`lib/data/`)
Xử lý truy xuất và lưu trữ dữ liệu:
- **Models**: Entities mở rộng với JSON serialization
- **DataSources**: Truy xuất dữ liệu từ API/Database
- **Repositories (Implementation)**: Triển khai interface từ domain

### 4. **Presentation Layer** (`lib/presentation/`)
UI và state management:
- **BLoCs**: State management logic
- **Pages**: Màn hình chính
- **Widgets**: Các component tái sử dụng

## 🚀 Getting Started

### Prerequisites
- Flutter 3.7.2 hoặc cao hơn
- Dart 3.7.2 hoặc cao hơn

### Installation

```bash
# Clone repository
git clone <repo_url>

# Navigate to project
cd vn_trader

# Get dependencies
flutter pub get

# Run app
flutter run
```

## 📦 Dependencies

### Core Dependencies
```yaml
bloc: ^8.1.0              # State management
flutter_bloc: ^8.1.0      # Flutter integration
equatable: ^2.0.5         # Object comparison
```

### Dev Dependencies
```yaml
bloc_test: ^9.1.0         # BLoC testing
flutter_lints: ^5.0.0     # Linting rules
```

## 🎯 Project Structure

```
lib/
├── core/                          # Core utilities
│   ├── constants/
│   │   ├── app_colors.dart
│   │   └── app_constants.dart
│   ├── theme/
│   │   ├── app_theme.dart         # Light/Dark theme
│   │   └── app_text_styles.dart
│   ├── utils/
│   │   ├── app_exception.dart     # Exception classes
│   │   ├── logger.dart            # Logging utility
│   │   └── extensions.dart        # Dart extensions
│   └── service_locator.dart       # DI container
│
├── domain/                        # Business logic
│   ├── entities/
│   │   └── user.dart              # Pure objects
│   ├── repositories/
│   │   └── user_repository.dart   # Abstract interfaces
│   └── usecases/
│       └── get_user_usecase.dart
│
├── data/                          # Data layer
│   ├── datasources/
│   │   └── user_datasource.dart   # API/DB access
│   ├── models/
│   │   └── user_model.dart        # JSON serialization
│   └── repositories/
│       └── user_repository_impl.dart
│
├── presentation/                  # UI layer
│   ├── bloc/
│   │   ├── counter/               # Counter BLoC example
│   │   │   ├── counter_bloc.dart
│   │   │   ├── counter_event.dart
│   │   │   ├── counter_state.dart
│   │   │   └── index.dart
│   │   └── index.dart
│   ├── pages/
│   │   └── home_page.dart
│   ├── widgets/
│   │   ├── loading_widget.dart
│   │   ├── error_widget.dart
│   │   └── empty_state_widget.dart
│   └── theme/
│
└── main.dart                      # App entry point
```

## 💡 BLoC Pattern Overview

### Lifecycle

```
User Interaction → Event → BLoC → State → UI Update
```

### Event - Sự kiện
```dart
abstract class MyEvent extends Equatable {
  const MyEvent();
}

class MyEventTriggered extends MyEvent {
  const MyEventTriggered();
}
```

### State - Trạng thái
```dart
class MyState extends Equatable {
  final String data;
  
  const MyState({required this.data});

  @override
  List<Object> get props => [data];
}
```

### BLoC - Logic
```dart
class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc() : super(const MyInitialState()) {
    on<MyEventTriggered>(_onMyEventTriggered);
  }

  Future<void> _onMyEventTriggered(
    MyEventTriggered event,
    Emitter<MyState> emit,
  ) async {
    emit(MyState(data: 'updated'));
  }
}
```

### Widget - UI
```dart
// Cung cấp BLoC
BlocProvider(
  create: (context) => MyBloc(),
  child: MyPage(),
)

// Lắng nghe State
BlocBuilder<MyBloc, MyState>(
  builder: (context, state) {
    return Text(state.data);
  },
)

// Phát Event
context.read<MyBloc>().add(const MyEventTriggered());
```

## 🧪 Testing

Chạy tests:
```bash
flutter test
```

Test BLoC với bloc_test:
```dart
blocTest<MyBloc, MyState>(
  'emits [MyState] when MyEvent is added',
  build: () => MyBloc(),
  act: (bloc) => bloc.add(const MyEvent()),
  expect: () => [isA<MyState>()],
)
```

## 🎨 Theme

Ứng dụng hỗ trợ 2 theme:
- **Light Theme** - Chủ đề sáng (mặc định)
- **Dark Theme** - Chủ đề tối

Chỉnh sửa theme trong `lib/core/theme/app_theme.dart`

## 🔧 Utility Classes

### Logger
```dart
Logger.info('Info message', tag: 'MyTag');
Logger.error('Error message', error: exception);
Logger.success('Success message');
```

### String Extensions
```dart
String text = 'hello';
text.capitalize;           // 'Hello'
text.isValidEmail;         // false
text.reverse;              // 'olleh'
```

### Exception Handling
```dart
try {
  // code
} on NetworkException catch (e) {
  print('Network error: ${e.message}');
} on CacheException catch (e) {
  print('Cache error: ${e.message}');
}
```

## 📋 Checklist - Tạo Feature Mới

- [ ] Tạo thư mục feature trong `lib/presentation/bloc/`
- [ ] Tạo Event class
- [ ] Tạo State class
- [ ] Tạo BLoC class
- [ ] Tạo Page widget
- [ ] Tạo Unit tests
- [ ] Cập nhật exports
- [ ] Cập nhật documentation

## 🔗 Useful Links

- [BLoC Library](https://bloclibrary.dev/)
- [Flutter Documentation](https://flutter.dev/)
- [Dart Documentation](https://dart.dev/)
- [Clean Architecture](https://resocoder.com/flutter-clean-architecture)

## 📝 Code Style

- Sử dụng `flutter format` để format code
- Sử dụng `flutter analyze` để check linting
- Viết test cho mỗi feature
- Document công khai của bạn

## 🤝 Contributing

1. Tạo branch cho feature mới
2. Commit changes với message rõ ràng
3. Push branch và tạo Pull Request
4. Code review trước merge

## 📄 License

This project is licensed under the MIT License.

## 👨‍💼 Author

VN Trader Team

---

**Hãy xem [SETUP.md](./SETUP.md) và [BLOC_GUIDE.md](./BLOC_GUIDE.md) để bắt đầu!** 🚀
