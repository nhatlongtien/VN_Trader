/// Example repository interface - tầng domain
/// Định nghĩa hợp đồng cho tầng data

import 'package:vn_trader/domain/entities/user.dart';

abstract class UserRepository {
  /// Lấy thông tin người dùng
  Future<User> getUser(String id);

  /// Lưu người dùng
  Future<void> saveUser(User user);

  /// Xóa người dùng
  Future<void> deleteUser(String id);
}
