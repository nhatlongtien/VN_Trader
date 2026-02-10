# StorageService Usage Guide

## Overview
`StorageService` là một service tái sử dụng được để lưu trữ dữ liệu local sử dụng SharedPreferences. Service này có thể lưu, đọc và xóa bất kỳ object nào.

## Location
File: `/lib/core/services/storage_service.dart`

---

## Generic Methods (Có thể tái sử dụng cho bất kỳ object nào)

### 1. Save Object
Lưu một object bất kỳ vào SharedPreferences:

```dart
// Example: Save any object
final data = {
  'id': '123',
  'name': 'John Doe',
  'email': 'john@example.com',
};

bool success = await StorageService.saveObject(
  key: 'my_custom_key',
  data: data,
);

if (success) {
  print('Object saved successfully');
} else {
  print('Failed to save object');
}
```

### 2. Get Object
Lấy một object từ SharedPreferences:

```dart
// Example: Get any object
Map<String, dynamic>? data = await StorageService.getObject(
  key: 'my_custom_key',
);

if (data != null) {
  print('Retrieved data: $data');
} else {
  print('No data found');
}
```

### 3. Delete Object
Xóa một object khỏi SharedPreferences:

```dart
// Example: Delete any object
bool success = await StorageService.deleteObject(
  key: 'my_custom_key',
);

if (success) {
  print('Object deleted successfully');
}
```

### 4. Clear All
Xóa toàn bộ dữ liệu trong SharedPreferences:

```dart
// Example: Clear all data
bool success = await StorageService.clearAll();

if (success) {
  print('All data cleared');
}
```

---

## Specific Methods for User Profile

### 1. Save Profile
Lưu user profile:

```dart
import 'package:vn_trader/core/services/storage_service.dart';
import 'package:vn_trader/data/models/profile_model.dart';

// In your BLoC or Repository
final profile = ProfileModel(
  id: '123',
  userId: 'user123',
  name: 'John Doe',
  email: 'john@example.com',
  avatarUrl: 'https://example.com/avatar.jpg',
  phoneNumber: '+84123456789',
  isAdmin: false,
);

// Save profile
bool saved = await StorageService.saveProfile(profile.toJson());

if (saved) {
  print('Profile saved successfully');
} else {
  print('Failed to save profile');
}
```

### 2. Get Profile
Lấy user profile đã lưu:

```dart
import 'package:vn_trader/core/services/storage_service.dart';
import 'package:vn_trader/data/models/profile_model.dart';

// Get profile
Map<String, dynamic>? profileData = await StorageService.getProfile();

if (profileData != null) {
  // Convert to ProfileModel
  final profile = ProfileModel.fromJson(profileData);
  print('User: ${profile.name}, Email: ${profile.email}');
} else {
  print('No profile found');
}
```

### 3. Delete Profile
Xóa user profile (ví dụ khi logout):

```dart
import 'package:vn_trader/core/services/storage_service.dart';

// Delete profile
bool deleted = await StorageService.deleteProfile();

if (deleted) {
  print('Profile deleted successfully');
  // Navigate to login screen
}
```

### 4. Check if Profile Exists
Kiểm tra xem user đã đăng nhập chưa:

```dart
import 'package:vn_trader/core/services/storage_service.dart';

// Check if profile exists
bool hasProfile = await StorageService.hasProfile();

if (hasProfile) {
  print('User is logged in');
  // Navigate to home screen
} else {
  print('User is not logged in');
  // Navigate to login screen
}
```

---

## Usage Examples in Different Layers

### In BLoC (Login)
```dart
import 'package:vn_trader/core/services/storage_service.dart';

// In LoginBloc
Future<void> _onLoginSubmitted(
  LoginSubmitted event,
  Emitter<LoginState> emit,
) async {
  try {
    final response = await _repository.loginWithEmailPassword(
      email: state.email,
      password: state.password,
    );

    if (response.user != null) {
      final profile = await _repository.getUserProfile(response.user!.id);
      
      if (profile != null) {
        // Save profile to local storage
        final saved = await StorageService.saveProfile(profile.toJson());
        
        if (saved) {
          emit(state.copyWith(status: LoginStatus.success));
        } else {
          throw Exception('Failed to save user profile locally');
        }
      }
    }
  } catch (e) {
    emit(state.copyWith(
      status: LoginStatus.failure,
      errorMessage: e.toString(),
    ));
  }
}
```

### In BLoC (Logout)
```dart
import 'package:vn_trader/core/services/storage_service.dart';

// In LogoutBloc or ProfileBloc
Future<void> _onLogoutPressed(
  LogoutPressed event,
  Emitter<ProfileState> emit,
) async {
  try {
    // Delete profile from local storage
    await StorageService.deleteProfile();
    
    // Or clear all data
    // await StorageService.clearAll();
    
    // Logout from Supabase
    await _authRepository.signOut();
    
    emit(state.copyWith(status: ProfileStatus.loggedOut));
  } catch (e) {
    emit(state.copyWith(
      status: ProfileStatus.error,
      errorMessage: e.toString(),
    ));
  }
}
```

### In App Initialization (Check Login Status)
```dart
import 'package:vn_trader/core/services/storage_service.dart';
import 'package:vn_trader/data/models/profile_model.dart';

// In main.dart or initial screen
class MyApp extends StatelessWidget {
  Future<bool> _checkLoginStatus() async {
    final hasProfile = await StorageService.hasProfile();
    
    if (hasProfile) {
      final profileData = await StorageService.getProfile();
      if (profileData != null) {
        final profile = ProfileModel.fromJson(profileData);
        print('Logged in as: ${profile.name}');
        return true;
      }
    }
    
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final isLoggedIn = snapshot.data ?? false;
          
          return MaterialApp(
            home: isLoggedIn ? HomeScreen() : LoginPage(),
          );
        }
        
        return const CircularProgressIndicator();
      },
    );
  }
}
```

### In Repository
```dart
import 'package:vn_trader/core/services/storage_service.dart';
import 'package:vn_trader/data/models/profile_model.dart';

class UserRepository {
  // Get current user profile from local storage
  Future<ProfileModel?> getCurrentProfile() async {
    final profileData = await StorageService.getProfile();
    
    if (profileData != null) {
      return ProfileModel.fromJson(profileData);
    }
    
    return null;
  }
  
  // Update profile both remotely and locally
  Future<void> updateProfile(ProfileModel profile) async {
    // Update in remote database
    await _remoteDataSource.updateProfile(profile);
    
    // Update in local storage
    await StorageService.saveProfile(profile.toJson());
  }
}
```

---

## Advanced Usage: Custom Objects

Bạn có thể sử dụng `StorageService` cho bất kỳ object nào khác:

```dart
// Example: Save settings
class AppSettings {
  final bool isDarkMode;
  final String language;
  final bool notificationsEnabled;

  AppSettings({
    required this.isDarkMode,
    required this.language,
    required this.notificationsEnabled,
  });

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'language': language,
      'notificationsEnabled': notificationsEnabled,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      isDarkMode: json['isDarkMode'] ?? false,
      language: json['language'] ?? 'en',
      notificationsEnabled: json['notificationsEnabled'] ?? true,
    );
  }
}

// Save settings
final settings = AppSettings(
  isDarkMode: true,
  language: 'vi',
  notificationsEnabled: true,
);

await StorageService.saveObject(
  key: 'app_settings',
  data: settings.toJson(),
);

// Get settings
final settingsData = await StorageService.getObject(key: 'app_settings');
if (settingsData != null) {
  final settings = AppSettings.fromJson(settingsData);
}
```

---

## Best Practices

1. **Keys**: Luôn sử dụng constant keys để tránh typo:
```dart
class StorageKeys {
  static const String profile = 'user_profile';
  static const String settings = 'app_settings';
  static const String token = 'auth_token';
}
```

2. **Error Handling**: Luôn kiểm tra kết quả trả về:
```dart
final saved = await StorageService.saveProfile(profile.toJson());
if (!saved) {
  // Handle error
  throw Exception('Failed to save profile');
}
```

3. **Type Safety**: Sử dụng models với fromJson/toJson:
```dart
// Good ✅
final profileData = await StorageService.getProfile();
final profile = ProfileModel.fromJson(profileData!);

// Bad ❌
final name = profileData['name']; // No type safety
```

4. **Null Safety**: Luôn kiểm tra null:
```dart
final profileData = await StorageService.getProfile();
if (profileData != null) {
  final profile = ProfileModel.fromJson(profileData);
  // Use profile
}
```

---

## Notes

- SharedPreferences lưu dữ liệu dưới dạng key-value pairs
- Dữ liệu được lưu persistently (không mất khi tắt app)
- Không nên lưu sensitive data (passwords, tokens) mà không mã hóa
- Phù hợp cho small data (settings, user info, etc.)
- Không phù hợp cho large data (images, videos, etc.)
