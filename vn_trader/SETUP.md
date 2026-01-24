# 🏗️ Cấu Trúc BLoC - VN Trader

Dự án đã được thiết lập với **BLoC Pattern** và **Clean Architecture**!

## 📚 Tài liệu

- **[BLOC_GUIDE.md](./BLOC_GUIDE.md)** - Hướng dẫn chi tiết về BLoC Pattern

## 📦 Cấu trúc thư mục đã tạo

```
lib/
├── core/                      # Tầng ứng dụng (Utilities, Constants, etc.)
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   ├── service_locator.dart
│   └── index.dart
│
├── data/                      # Tầng dữ liệu
│   ├── datasources/          # Remote/Local data sources
│   ├── models/               # Data models (JSON serialization)
│   └── repositories/         # Repository implementations
│
├── domain/                    # Tầng miền (Business Logic)
│   ├── entities/             # Plain objects
│   ├── repositories/         # Repository interfaces
│   └── usecases/             # Use cases
│
└── presentation/             # Tầng giao diện
    ├── bloc/                 # BLoC state management
    │   ├── counter/          # Counter BLoC (example)
    │   └── index.dart
    ├── pages/
    ├── widgets/
    └── theme/
```

## 🚀 Hướng dẫn nhanh

### 1. Chạy dự án
```bash
flutter pub get
flutter run
```

### 2. Tạo BLoC mới
```bash
# Tạo thư mục cho feature mới
mkdir -p lib/presentation/bloc/my_feature

# Tạo các file:
# - my_feature_event.dart
# - my_feature_state.dart  
# - my_feature_bloc.dart
# - index.dart
```

Xem chi tiết trong [BLOC_GUIDE.md](./BLOC_GUIDE.md)

### 3. Sử dụng BLoC trong Widget
```dart
// 1. Cung cấp BLoC
BlocProvider(
  create: (context) => MyBloc(),
  child: MyPage(),
)

// 2. Lắng nghe trạng thái
BlocBuilder<MyBloc, MyState>(
  builder: (context, state) {
    return Text('State: $state');
  },
)

// 3. Phát sự kiện
context.read<MyBloc>().add(MyEvent());
```

## 📁 Ví dụ files đã tạo

- ✅ **BLoC Example**: `lib/presentation/bloc/counter/`
- ✅ **Entity Example**: `lib/domain/entities/user.dart`
- ✅ **UseCase Example**: `lib/domain/usecases/get_user_usecase.dart`
- ✅ **Repository Example**: `lib/data/repositories/user_repository_impl.dart`
- ✅ **DataSource Example**: `lib/data/datasources/user_datasource.dart`
- ✅ **Model Example**: `lib/data/models/user_model.dart`

## 📝 Dependencies đã thêm

```yaml
dependencies:
  bloc: ^8.1.0
  flutter_bloc: ^8.1.0
  equatable: ^2.0.5
```

## ✨ Tính năng

- ✅ **Separation of Concerns**: Mỗi lớp có trách nhiệm riêng
- ✅ **Type-safe**: Sử dụng Dart's type system
- ✅ **Testable**: Dễ test từng thành phần
- ✅ **Scalable**: Dễ thêm features mới
- ✅ **Maintainable**: Code rõ ràng, dễ bảo trì

## 🎯 Best Practices

1. **Một BLoC cho một Feature** - Tách biệt các chức năng riêng biệt
2. **Sử dụng Equatable** - So sánh states và events
3. **Immutable States** - States không thể thay đổi
4. **Error Handling** - Xử lý lỗi một cách nhất quán
5. **Service Locator** - Inject dependencies

## 🔗 Tài liệu

- [BLoC Library Docs](https://bloclibrary.dev/)
- [Flutter BLoC Pub Dev](https://pub.dev/packages/flutter_bloc)
- [Clean Architecture](https://resocoder.com/flutter-clean-architecture)

---

**Hãy theo dõi [BLOC_GUIDE.md](./BLOC_GUIDE.md) để biết thêm chi tiết!** 📖
