import 'app_exception.dart';

class NetworkException extends AppException {
  NetworkException([String message = 'Lỗi kết nối mạng'])
      : super(message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String message = 'Bạn chưa đăng nhập'])
      : super(message, code: '401');
}

class NotFoundException extends AppException {
  NotFoundException([String message = 'Không tìm thấy dữ liệu'])
      : super(message, code: '404');
}

class ServerException extends AppException {
  ServerException([String message = 'Lỗi hệ thống'])
      : super(message, code: '500');
}

class UnknownException extends AppException {
  UnknownException([String message = 'Đã có lỗi xảy ra'])
      : super(message);
}