import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/supabase/base_repository.dart';
import '../../data/models/profile_model.dart';

class LoginRepository {
  final supabase = Supabase.instance.client;
  final _repository = BaseRepository();

  Future<AuthResponse> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // Đăng nhập thành công
      if (response.user != null) {
        return response;
      }

      throw Exception('Login failed');
    } on AuthException catch (e) {
      // Lỗi do Supabase trả về (sai mật khẩu, user không tồn tại…)
      throw Exception(e.message);
    } catch (e) {
      // Lỗi không xác định
      throw Exception('Unexpected error: $e');
    }
  }
  
  Future<ProfileModel?> getUserProfile(String userId) async {
    try {
      final response = await _repository.getSingleWhere(
        table: "users",
        field: "user_id",
        value: userId,
        fromJson: (json) => ProfileModel.fromJson(json),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }


  }
  
  
}