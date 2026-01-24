/// Example repository implementation - tầng data
/// Triển khai interface từ tầng domain, kết nối giữa datasources và domain layer

import 'package:vn_trader/data/datasources/user_datasource.dart';
import 'package:vn_trader/data/models/user_model.dart';
import 'package:vn_trader/domain/entities/user.dart';
import 'package:vn_trader/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User> getUser(String id) async {
    try {
      // Thử lấy từ remote trước
      final user = await remoteDataSource.getUser(id);

      // Lưu vào local cache
      await localDataSource.saveUser(user);

      return user;
    } catch (e) {
      // Nếu remote thất bại, thử lấy từ local
      try {
        return await localDataSource.getUser(id);
      } catch (_) {
        rethrow;
      }
    }
  }

  @override
  Future<void> saveUser(User user) async {
    final userModel = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
    );

    try {
      // Lưu vào local đầu tiên (nhanh)
      await localDataSource.saveUser(userModel);

      // Sau đó lưu lên remote (có thể async)
      await remoteDataSource.saveUser(userModel);
    } catch (e) {
      throw Exception('Failed to save user: $e');
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    // TODO: Implement delete logic
    throw UnimplementedError();
  }
}
