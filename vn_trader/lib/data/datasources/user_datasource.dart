/// Example datasource - tầng data
/// Xử lý truy xuất dữ liệu từ nguồn bên ngoài (API, Database, etc.)

import 'package:vn_trader/data/models/user_model.dart';

abstract class UserDataSource {
  /// Lấy dữ liệu người dùng từ server
  Future<UserModel> getUser(String id);

  /// Lưu người dùng lên server
  Future<void> saveUser(UserModel user);
}

class UserRemoteDataSource implements UserDataSource {
  // TODO: Inject HTTP client

  @override
  Future<UserModel> getUser(String id) async {
    try {
      // TODO: Gọi API
      // final response = await _httpClient.get('/users/$id');
      // return UserModel.fromJson(response.data);

      // Example implementation
      throw UnimplementedError('Remote API not implemented');
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      // TODO: Gọi API POST/PUT
      throw UnimplementedError('Remote API not implemented');
    } catch (e) {
      throw Exception('Failed to save user: $e');
    }
  }
}

class UserLocalDataSource implements UserDataSource {
  // TODO: Inject Database instance

  @override
  Future<UserModel> getUser(String id) async {
    try {
      // TODO: Truy vấn database cục bộ
      throw UnimplementedError('Local database not implemented');
    } catch (e) {
      throw Exception('Failed to fetch user from local database: $e');
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      // TODO: Lưu vào database cục bộ
      throw UnimplementedError('Local database not implemented');
    } catch (e) {
      throw Exception('Failed to save user to local database: $e');
    }
  }
}
