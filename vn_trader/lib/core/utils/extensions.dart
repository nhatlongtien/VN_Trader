/// Utility extensions for String
extension StringExtension on String {
  /// Check if string is empty or null
  bool get isEmpty => trim().isEmpty;

  /// Check if string is not empty
  bool get isNotEmpty => trim().isNotEmpty;

  /// Check if string is a valid email
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Capitalize first letter
  String get capitalize => isEmpty ? this : '${this[0].toUpperCase()}${substring(1).toLowerCase()}';

  /// Reverse string
  String get reverse => split('').reversed.join('');
}

/// Utility extensions for List
extension ListExtension<T> on List<T> {
  /// Check if list is empty
  bool get isEmpty => length == 0;

  /// Check if list is not empty
  bool get isNotEmpty => length > 0;

  /// Get first element or null
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null
  T? get lastOrNull => isEmpty ? null : last;
}

/// Utility extensions for Map
extension MapExtension<K, V> on Map<K, V> {
  /// Check if map is empty
  bool get isEmpty => length == 0;

  /// Check if map is not empty
  bool get isNotEmpty => length > 0;
}
