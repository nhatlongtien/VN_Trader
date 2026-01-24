/// Logger utility for debugging
class Logger {
  static const String _prefix = '🔷 VN_TRADER';

  /// Log info message
  static void info(String message, {String? tag}) {
    final prefix = tag != null ? '$_prefix[$tag]' : _prefix;
    print('$prefix ℹ️ $message');
  }

  /// Log error message
  static void error(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    final prefix = tag != null ? '$_prefix[$tag]' : _prefix;
    print('$prefix ❌ $message');
    if (error != null) print('Error: $error');
    if (stackTrace != null) print('StackTrace: $stackTrace');
  }

  /// Log warning message
  static void warning(String message, {String? tag}) {
    final prefix = tag != null ? '$_prefix[$tag]' : _prefix;
    print('$prefix ⚠️ $message');
  }

  /// Log success message
  static void success(String message, {String? tag}) {
    final prefix = tag != null ? '$_prefix[$tag]' : _prefix;
    print('$prefix ✅ $message');
  }

  /// Log debug message
  static void debug(String message, {String? tag}) {
    final prefix = tag != null ? '$_prefix[$tag]' : _prefix;
    print('$prefix 🐛 $message');
  }
}
