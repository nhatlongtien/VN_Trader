import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_exception.dart';
import 'network_exception.dart';

AppException mapSupabaseError(dynamic error) {
  if (error is AuthException) {
    return UnauthorizedException(error.message);
  }

  if (error is PostgrestException) {
    switch (error.code) {
      case '42501': // RLS
        return UnauthorizedException('Bạn không có quyền truy cập');
      case 'PGRST116':
        return NotFoundException();
      default:
        return ServerException(error.message);
    }
  }

  return UnknownException(error.toString());
}