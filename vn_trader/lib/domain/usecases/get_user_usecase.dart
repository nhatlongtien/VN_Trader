/// Example usecase - tầng domain
/// Chứa logic nghiệp vụ (business logic)

import 'package:vn_trader/domain/entities/user.dart';
import 'package:vn_trader/domain/repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository repository;

  GetUserUseCase({required this.repository});

  /// Lấy thông tin người dùng
  /// Có thể thêm validation, logging, transformation tại đây
  Future<User> call(String userId) async {
    return await repository.getUser(userId);
  }
}
