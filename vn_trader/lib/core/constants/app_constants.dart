/// Application constants
class AppConstants {
  // API endpoints
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = '/v1';

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration syncTimeout = Duration(seconds: 60);

  // App info
  static const String appName = 'VN Trader';
  static const String appVersion = '1.0.0';

  // Keys
  static const String userPreferencesKey = 'user_preferences';
  static const String authTokenKey = 'auth_token';
}
