# 📁 VN Trader - Cấu Trúc Dự Án Hoàn Chỉnh

## Folder Structure

```
vn_trader/
│
├── 📄 pubspec.yaml                    # Dependencies & project config
├── 📄 pubspec.lock                    # Lock file
├── 📄 analysis_options.yaml           # Lint rules
│
├── 📚 README.md                       # Main documentation
├── 📚 SETUP.md                        # Setup guide
├── 📚 BLOC_GUIDE.md                   # BLoC pattern guide
├── 📚 BLoC_TEMPLATE.md                # Quick template
├── 📚 COMPLETION_SUMMARY.md           # Setup summary
│
├── lib/                               # Main source code
│   │
│   ├── 📄 main.dart                   # App entry point
│   │
│   ├── core/                          # ⚙️ Core Layer - Utilities
│   │   ├── 📄 index.dart              # Core exports
│   │   ├── 📄 service_locator.dart    # DI container
│   │   │
│   │   ├── constants/                 # Constants
│   │   │   ├── 📄 index.dart
│   │   │   ├── 📄 app_constants.dart  # App constants
│   │   │   └── 📄 app_colors.dart     # Color palette
│   │   │
│   │   ├── theme/                     # Theme configuration
│   │   │   ├── 📄 index.dart
│   │   │   ├── 📄 app_theme.dart      # Light/Dark themes
│   │   │   └── 📄 app_text_styles.dart# Text styles
│   │   │
│   │   └── utils/                     # Utilities
│   │       ├── 📄 index.dart
│   │       ├── 📄 logger.dart         # Logging utility
│   │       ├── 📄 extensions.dart     # Dart extensions
│   │       └── 📄 app_exception.dart  # Exception classes
│   │
│   ├── domain/                        # 📖 Domain Layer - Business Logic
│   │   ├── 📄 index.dart              # Domain exports
│   │   │
│   │   ├── entities/                  # Pure objects
│   │   │   └── 📄 user.dart           # User entity example
│   │   │
│   │   ├── repositories/              # Abstract interfaces
│   │   │   └── 📄 user_repository.dart# User repo interface
│   │   │
│   │   └── usecases/                  # Business logic
│   │       └── 📄 get_user_usecase.dart# Get user use case
│   │
│   ├── data/                          # 🗄️ Data Layer - Data Handling
│   │   ├── 📄 index.dart              # Data exports
│   │   │
│   │   ├── datasources/               # Remote/Local sources
│   │   │   └── 📄 user_datasource.dart# API & local access
│   │   │
│   │   ├── models/                    # Data models
│   │   │   └── 📄 user_model.dart     # User model (JSON)
│   │   │
│   │   └── repositories/              # Repository implementations
│   │       └── 📄 user_repository_impl.dart
│   │
│   └── presentation/                  # 🎨 Presentation Layer - UI
│       ├── 📄 index.dart              # Presentation exports
│       │
│       ├── bloc/                      # State Management
│       │   ├── 📄 index.dart          # BLoC exports
│       │   │
│       │   └── counter/               # Counter BLoC (example)
│       │       ├── 📄 counter_bloc.dart   # BLoC logic
│       │       ├── 📄 counter_event.dart  # Events
│       │       ├── 📄 counter_state.dart  # States
│       │       └── 📄 index.dart          # Feature exports
│       │
│       ├── pages/                     # Screens/Pages
│       │   ├── 📄 index.dart
│       │   └── 📄 home_page.dart      # Home page
│       │
│       ├── widgets/                   # Reusable widgets
│       │   ├── 📄 index.dart
│       │   ├── 📄 loading_widget.dart
│       │   ├── 📄 error_widget.dart
│       │   └── 📄 empty_state_widget.dart
│       │
│       └── theme/                     # UI-specific theme
│           └── (placeholder)
│
├── test/                              # Tests
│   ├── 📄 widget_test.dart           # Widget tests (default)
│   │
│   └── bloc/                         # BLoC tests
│       └── 📄 counter_bloc_test.dart # Counter test example
│
├── android/                           # Android platform
│   └── ... (Android specific files)
│
├── ios/                              # iOS platform
│   └── ... (iOS specific files)
│
├── macos/                            # macOS platform
│   └── ... (macOS specific files)
│
├── windows/                          # Windows platform
│   └── ... (Windows specific files)
│
├── linux/                            # Linux platform
│   └── ... (Linux specific files)
│
└── web/                              # Web platform
    └── ... (Web specific files)
```

## 📊 File Count Summary

### Core Layer
- 1 Service Locator file
- 2 Constants files
- 2 Theme files
- 3 Utils files
- **Total: 8 files**

### Domain Layer
- 1 Entity file
- 1 Repository interface
- 1 UseCase file
- **Total: 3 files**

### Data Layer
- 1 DataSource file
- 1 Model file
- 1 Repository implementation
- **Total: 3 files**

### Presentation Layer
- 1 Counter BLoC (4 files)
- 1 Home Page
- 3 Reusable Widgets
- **Total: 9 files**

### Tests
- 1 Counter BLoC test
- 1 Default widget test
- **Total: 2 files**

### Documentation
- README.md
- SETUP.md
- BLOC_GUIDE.md
- BLoC_TEMPLATE.md
- COMPLETION_SUMMARY.md
- PROJECT_STRUCTURE.md (this file)
- **Total: 6 files**

---

## 🔄 Data Flow

```
┌──────────────────────────────────────────────────────────┐
│ USER INTERACTION (Tap button, scroll, etc.)              │
└──────────────────────────────────────────────────────────┘
                         ↓
┌──────────────────────────────────────────────────────────┐
│ EVENT EMISSION (MyEvent added to BLoC)                   │
│ context.read<MyBloc>().add(MyEvent())                   │
└──────────────────────────────────────────────────────────┘
                         ↓
┌──────────────────────────────────────────────────────────┐
│ BLoC PROCESSES EVENT                                     │
│ • Call UseCase/Repository                                │
│ • Handle business logic                                  │
│ • Error handling                                         │
└──────────────────────────────────────────────────────────┘
                         ↓
┌──────────────────────────────────────────────────────────┐
│ STATE EMISSION (MyState emitted)                         │
│ emit(MyState(...))                                       │
└──────────────────────────────────────────────────────────┘
                         ↓
┌──────────────────────────────────────────────────────────┐
│ WIDGET REBUILD (BlocBuilder listens to state)            │
│ UI updates based on new state                            │
└──────────────────────────────────────────────────────────┘
```

## 📦 Dependencies Map

```
presentation/
├── bloc (flutter_bloc, bloc)
├── pages
└── widgets
    └── uses core/theme, core/utils

domain/
├── entities
├── repositories (abstract)
└── usecases
    └── depends on repositories

data/
├── datasources
├── models
└── repositories (implementation)
    ├── implements domain repositories
    └── uses datasources

core/
├── constants
├── theme
└── utils (exceptions, logger, extensions)
```

## 🎯 Import Pattern

### Good ✅
```dart
// Use indexed imports
import 'package:vn_trader/presentation/bloc/index.dart';
import 'package:vn_trader/core/theme/index.dart';

// Use specific imports when needed
import 'package:vn_trader/domain/entities/user.dart';
```

### Avoid ❌
```dart
// Long import paths
import 'package:vn_trader/presentation/bloc/counter/counter_bloc.dart';

// Circular imports
// A imports B, B imports A
```

## 🧩 Layer Dependencies

### Allowed ✅
- Presentation → Domain
- Presentation → Data
- Presentation → Core
- Domain → Core
- Data → Domain
- Data → Core

### Not Allowed ❌
- Core → (any)
- Domain → Presentation
- Domain → Data
- Data → Presentation

## 📋 Checklist for New Features

```
Creating new feature "auth":

✅ Create folders:
   lib/presentation/bloc/auth/
   lib/domain/entities/
   lib/domain/repositories/
   lib/domain/usecases/
   lib/data/datasources/
   lib/data/models/
   lib/data/repositories/
   lib/presentation/pages/
   test/bloc/

✅ Create files:
   auth_event.dart, auth_state.dart, auth_bloc.dart
   auth_user.dart (entity)
   auth_repository.dart (interface)
   auth_usecase.dart
   auth_datasource.dart
   auth_user_model.dart
   auth_repository_impl.dart
   auth_page.dart
   auth_bloc_test.dart

✅ Update exports:
   lib/presentation/bloc/index.dart
   lib/presentation/pages/index.dart
   lib/domain/index.dart
   lib/data/index.dart

✅ Document in README.md

✅ Write tests first (TDD)
```

---

**Built with ❤️ using BLoC Pattern & Clean Architecture**

Xem [COMPLETION_SUMMARY.md](./COMPLETION_SUMMARY.md) để biết thêm chi tiết!
