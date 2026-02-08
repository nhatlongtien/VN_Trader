# Quick Test Guide - Registration Feature

## ✅ Implementation Complete

Tính năng đăng ký đã được implement đầy đủ với:
- ✅ UI kết nối với BLoC
- ✅ Validation đầy đủ
- ✅ Integration với Supabase Auth
- ✅ Lưu user data vào database
- ✅ Error handling
- ✅ Loading states
- ✅ Success/Error notifications

## 🧪 How to Test

### 1. Prepare Supabase
Đảm bảo bảng `users` đã được tạo trong Supabase:

```sql
CREATE TABLE users (
  id UUID PRIMARY KEY REFERENCES auth.users(id),
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

ALTER TABLE users ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can insert their own data"
  ON users FOR INSERT
  WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can view all users"
  ON users FOR SELECT
  USING (true);
```

### 2. Test Cases

#### ✅ Happy Path (Successful Registration)
1. Mở Register Screen
2. Nhập:
   - Full Name: "John Doe"
   - Email: "john.doe@example.com"
   - Password: "password123"
   - Confirm Password: "password123"
3. Check "I agree to the Terms & Conditions"
4. Click "Register Now"
5. **Expected**: 
   - Loading spinner xuất hiện
   - Green SnackBar: "Registration successful! Please check your email."
   - Navigate về Login Screen
   - User mới xuất hiện trong Supabase Auth và bảng `users`

#### ❌ Validation Tests

**Test 1: Empty Fields**
- Để trống bất kỳ field nào -> Click "Register Now"
- **Expected**: Red SnackBar "Please fill all fields"

**Test 2: Invalid Email**
- Email: "notanemail" (không có @)
- **Expected**: Red SnackBar "Invalid email format"

**Test 3: Password Mismatch**
- Password: "password123"
- Confirm Password: "different123"
- **Expected**: Red SnackBar "Passwords do not match"

**Test 4: Short Password**
- Password: "12345" (< 6 ký tự)
- **Expected**: Red SnackBar "Password must be at least 6 characters"

**Test 5: Terms Not Agreed**
- Không check checkbox terms
- **Expected**: Red SnackBar "You must agree to the terms"

#### ❌ Error Cases

**Test 6: Duplicate Email**
- Đăng ký với email đã tồn tại
- **Expected**: Red SnackBar với message từ Supabase (e.g., "User already registered")

**Test 7: Network Error**
- Tắt internet -> Thử đăng ký
- **Expected**: Red SnackBar với network error message

### 3. Verification Steps

Sau khi đăng ký thành công:

1. **Check Supabase Dashboard**
   - Go to Authentication → Users
   - Verify user mới xuất hiện với email đã nhập

2. **Check Users Table**
   - Go to Table Editor → users
   - Verify record mới với:
     - `id` = auth user id
     - `name` = full name đã nhập
     - `email` = email đã nhập
     - `created_at` = timestamp hiện tại

3. **Check Email Confirmation** (nếu enabled)
   - Check inbox của email đã dùng
   - Should receive confirmation email từ Supabase

## 🔍 Debug Tips

### If registration fails:

1. **Check Supabase Connection**
   ```dart
   // In RegisterAccountRepository
   print('Supabase client: ${_repository.client}');
   ```

2. **Check Network Logs**
   - Enable network logging trong Flutter DevTools
   - Check API calls đến Supabase

3. **Check Supabase Logs**
   - Go to Supabase Dashboard → Logs
   - Check for any errors during signup

4. **Verify RLS Policies**
   - Make sure users table có correct policies
   - Test policy với SQL:
   ```sql
   SELECT * FROM users WHERE auth.uid() = id;
   ```

## 📱 UI States

### Normal State
- All fields enabled
- Button: "Register Now" (enabled nếu all fields filled)

### Loading State
- Button shows CircularProgressIndicator
- Button disabled
- User không thể edit fields

### Success State
- Green SnackBar appears
- Screen navigates back to Login

### Error State
- Red SnackBar with error message
- User có thể fix và retry

## 🎯 Next Steps (Optional Improvements)

1. **Add Email Verification Flow**
   - Show message to check email
   - Add resend verification email button

2. **Improve Password Validation**
   - Check for uppercase, lowercase, numbers
   - Show password strength indicator

3. **Add Loading Overlay**
   - Thay vì chỉ disable button, show full-screen loading

4. **Add Analytics**
   - Track registration success/failure rates
   - Track which validation fails most often

5. **Add Social Login**
   - Implement Google Sign Up
   - Implement Apple Sign Up

## ✨ Files Modified

1. `lib/presentation/bloc/register/register_bloc.dart` - Added repository & validation logic
2. `lib/presentation/pages/register_screen.dart` - Connected UI to BLoC
3. `lib/data/repositories/register_account_repository.dart` - Implemented Supabase registration

All files are error-free and ready to use! 🚀
