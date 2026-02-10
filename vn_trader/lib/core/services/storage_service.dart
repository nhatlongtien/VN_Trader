import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vn_trader/data/models/profile_model.dart';

/// Service for managing local storage using SharedPreferences
/// This is a reusable service that can store, retrieve, and delete any object
class StorageService {
  static const String _profileKey = 'user_profile';

  /// Save an object to SharedPreferences
  /// The object must have a toJson() method
  static Future<bool> saveObject<T>({
    required String key,
    required Map<String, dynamic> data,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(data);
      return await prefs.setString(key, jsonString);
    } catch (e) {
      print('Error saving object to SharedPreferences: $e');
      return false;
    }
  }

  /// Get an object from SharedPreferences
  /// Returns null if key doesn't exist or there's an error
  static Future<Map<String, dynamic>?> getObject({
    required String key,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(key);

      if (jsonString == null) {
        return null;
      }

      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      print('Error getting object from SharedPreferences: $e');
      return null;
    }
  }

  /// Delete an object from SharedPreferences
  static Future<bool> deleteObject({
    required String key,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(key);
    } catch (e) {
      print('Error deleting object from SharedPreferences: $e');
      return false;
    }
  }

  /// Clear all data from SharedPreferences
  static Future<bool> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.clear();
    } catch (e) {
      print('Error clearing SharedPreferences: $e');
      return false;
    }
  }

  // === Specific methods for UserProfile ===

  /// Save user profile to SharedPreferences
  static Future<bool> saveProfile(Map<String, dynamic> profileData) async {
    return await saveObject(
      key: _profileKey,
      data: profileData,
    );
  }

  /// Get user profile from SharedPreferences
  static Future<ProfileModel?> getProfile() async {
    final data = await getObject(key: _profileKey);
    if (data == null) return null;
    return ProfileModel.fromJson(data);
  }

  /// Delete user profile from SharedPreferences
  static Future<bool> deleteProfile() async {
    return await deleteObject(key: _profileKey);
  }

  /// Check if user profile exists
  static Future<bool> hasProfile() async {
    final profile = await getProfile();
    return profile != null;
  }
}
