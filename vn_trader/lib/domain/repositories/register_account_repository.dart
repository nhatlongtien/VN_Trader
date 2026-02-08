import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vn_trader/core/supabase/base_repository.dart';
import 'package:vn_trader/data/index.dart';

class RegisterAccountRepository  {
  final _repository = BaseRepository();

  Future<Map<String, dynamic>> registerWithEmail(String email, String password, String fullName) async {
    try {
      // Sign up user with Supabase Auth
      final authResponse = await _repository.client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
        }
      );

      final user = authResponse.user;
      if (user != null) {
        // Insert user data into users table
        final data = {
          'user_id': user.id,
          'name': fullName,
          'email': email,
          'phone_number': "0359386943"
        };

        final response = await _repository.insert<Map<String, dynamic>>(
          table: 'users',
          data: data,
          fromJson: (json) => json,
        );

        return response;
      } else {
        throw Exception('Registration failed: No user returned');
      }
    } on AuthApiException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      // Handle other errors
      throw Exception(e.toString());
    }
  }



}