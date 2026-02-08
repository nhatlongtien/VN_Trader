# Registration Feature Implementation

## Overview
Đã implement xong tính năng đăng ký người dùng với Supabase. Khi nhấn nút "Register Now", hệ thống sẽ:
1. Validate thông tin nhập vào
2. Tạo tài khoản authentication trên Supabase
3. Lưu thông tin người dùng vào bảng `users`
4. Hiển thị thông báo thành công hoặc lỗi

## Changes Made

### 1. RegisterBloc (`lib/presentation/bloc/register/register_bloc.dart`)
- Thêm dependency `RegisterAccountRepository`
- Implement logic validate đầy đủ:
  - Kiểm tra các trường bắt buộc
  - Validate format email
  - Kiểm tra password match
  - Kiểm tra độ dài password (tối thiểu 6 ký tự)
  - Kiểm tra checkbox terms & conditions
- Gọi repository để đăng ký user
- Xử lý error và success states

### 2. RegisterAccountRepository (`lib/data/repositories/register_account_repository.dart`)
- Method `registerWithEmail()` thực hiện:
  1. Sign up user qua Supabase Auth với email/password
  2. Lưu thông tin user vào bảng `users` với fields:
     - `id`: UUID từ Supabase Auth
     - `name`: Full name của user
     - `email`: Email address
  3. Return `UserModel` object

### 3. RegisterScreen (`lib/presentation/pages/register_screen.dart`)
- Wrap với `BlocProvider` để provide `RegisterBloc`
- Thêm `BlocListener` để:
  - Hiển thị SnackBar khi đăng ký thành công (màu xanh)
  - Hiển thị SnackBar khi có lỗi (màu đỏ)
  - Navigate về màn hình login khi thành công
- Connect tất cả TextFields với BLoC events:
  - `RegisterFullNameChanged`
  - `RegisterEmailChanged`
  - `RegisterPasswordChanged`
  - `RegisterConfirmPasswordChanged`
- Connect checkbox với `RegisterTermsToggled` event
- Button "Register Now":
  - Dispatch `RegisterSubmitted` event khi click
  - Hiển thị CircularProgressIndicator khi đang submit
  - Disable button trong lúc processing

## How It Works

### Flow Đăng Ký:
1. User nhập thông tin vào các trường
2. Mỗi lần thay đổi -> dispatch event tương ứng -> update state
3. User nhấn "Register Now"
4. BLoC validate tất cả thông tin:
   - Các trường không được để trống
   - Email phải đúng format
   - Password >= 6 ký tự
   - Password và Confirm Password phải giống nhau
   - Phải check "I agree to the Terms & Conditions"
5. Nếu validate pass:
   - Gọi `repository.registerWithEmail()`
   - Repository tạo auth user trên Supabase
   - Repository insert record vào bảng `users`
6. Hiển thị kết quả:
   - Success: SnackBar xanh + navigate về login
   - Error: SnackBar đỏ với message lỗi cụ thể

## Supabase Setup Required

Đảm bảo bảng `users` trong Supabase có cấu trúc:
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY REFERENCES auth.users(id),
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Policy cho insert (user có thể tạo record của chính họ)
CREATE POLICY "Users can insert their own data"
  ON users FOR INSERT
  WITH CHECK (auth.uid() = id);

-- Policy cho select (user có thể đọc data của mọi người)
CREATE POLICY "Users can view all users"
  ON users FOR SELECT
  USING (true);
```

## Testing

Để test tính năng:
1. Mở app và navigate đến Register Screen
2. Nhập thông tin:
   - Full Name: "Test User"
   - Email: "test@example.com"
   - Password: "password123"
   - Confirm Password: "password123"
   - Check "I agree to terms"
3. Nhấn "Register Now"
4. Kiểm tra:
   - Loading indicator hiển thị
   - SnackBar success xuất hiện
   - Navigate về login screen
   - Check Supabase dashboard để xem user mới

## Error Handling

Các lỗi được handle:
- Validation errors (hiển thị message cụ thể)
- Supabase auth errors (email đã tồn tại, network error, etc.)
- Database errors (lỗi khi insert vào bảng users)

Tất cả errors đều được map thành message dễ hiểu cho user.

## Notes

- Password tối thiểu 6 ký tự (theo yêu cầu default của Supabase)
- Sau khi đăng ký thành công, user cần check email để verify (nếu enable email confirmation trong Supabase)
- User data được lưu đồng bộ vào bảng `users` ngay sau khi tạo auth account
