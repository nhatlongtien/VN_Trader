# Giải Quyết Lỗi Rate Limit (429) - Supabase

## 🔴 Lỗi Bạn Gặp Phải

```
AuthApiException(message: email rate limit exceeded, statusCode 429)
```

## 🤔 Nguyên Nhân

Supabase có giới hạn số lượng email có thể gửi trong một khoảng thời gian để:
- Tránh spam
- Bảo vệ hệ thống khỏi abuse
- Giảm chi phí email service

**Rate limits mặc định:**
- **Email Sign Up**: 3-4 emails mỗi giờ cho cùng một IP address
- **Email Verification**: Giới hạn tương tự
- **Password Reset**: Giới hạn tương tự

## ✅ Đã Fix Trong Code

Tôi đã cập nhật `RegisterAccountRepository` để:

1. **Catch AuthApiException riêng biệt**
   ```dart
   on AuthApiException catch (e) {
     if (e.statusCode == '429') {
       throw Exception('Too many registration attempts. Please try again in a few minutes.');
     }
   }
   ```

2. **Show message rõ ràng cho user**
   - User sẽ thấy: "Too many registration attempts. Please try again in a few minutes."
   - Thay vì lỗi technical khó hiểu

## 🛠️ Giải Pháp Ngay Lập Tức

### Option 1: Đợi (Recommended)
Đợi **60 phút** rồi thử lại. Rate limit sẽ reset tự động.

### Option 2: Thay Đổi IP
- Chuyển sang mạng khác (VPN, Mobile Data, WiFi khác)
- Clear app cache và thử lại

### Option 3: Dùng Email Khác
- Thử với email address khác
- Nhưng vẫn bị limit nếu cùng IP

### Option 4: Kiểm Tra Supabase Dashboard
1. Vào Supabase Dashboard
2. Go to **Authentication** → **Rate Limits**
3. Check xem có thể tạm thời tăng limit không (chỉ cho development)

## 🚀 Giải Pháp Lâu Dài

### 1. Development Mode - Disable Email Confirmation

**Trong Supabase Dashboard:**
```
Settings → Authentication → Email Auth
→ Uncheck "Enable email confirmations"
```

**Ưu điểm:**
- Không gửi email khi đăng ký
- Không bị rate limit trong development
- Test nhanh hơn

**Nhược điểm:**
- User không verify email
- Chỉ nên dùng trong development

### 2. Use Local Supabase (Cho Development)

Install Supabase CLI và run local:
```bash
# Install Supabase CLI
npm install -g supabase

# Init local project
supabase init

# Start local Supabase
supabase start
```

**Ưu điểm:**
- Không giới hạn
- Test offline
- Nhanh hơn

### 3. Implement Retry Logic với Exponential Backoff

```dart
Future<UserModel> registerWithEmailRetry(
  String email, 
  String password, 
  String fullName,
  {int maxRetries = 3}
) async {
  int retryCount = 0;
  
  while (retryCount < maxRetries) {
    try {
      return await registerWithEmail(email, password, fullName);
    } on AuthApiException catch (e) {
      if (e.statusCode == '429' && retryCount < maxRetries - 1) {
        // Wait before retry (exponential backoff)
        int waitTime = pow(2, retryCount).toInt() * 1000; // 1s, 2s, 4s
        await Future.delayed(Duration(milliseconds: waitTime));
        retryCount++;
        continue;
      }
      rethrow;
    }
  }
  throw Exception('Max retries exceeded');
}
```

### 4. Add Client-Side Rate Limiting

Prevent user từ spamming button:

```dart
// In RegisterBloc
DateTime? _lastSubmitTime;
final _submitCooldown = Duration(seconds: 10);

on<RegisterSubmitted>((event, emit) async {
  // Check cooldown
  if (_lastSubmitTime != null) {
    final timeSinceLastSubmit = DateTime.now().difference(_lastSubmitTime!);
    if (timeSinceLastSubmit < _submitCooldown) {
      final remainingSeconds = _submitCooldown.inSeconds - timeSinceLastSubmit.inSeconds;
      emit(state.copyWith(
        isSubmitting: false, 
        isFailure: true, 
        errorMessage: 'Please wait $remainingSeconds seconds before trying again'
      ));
      return;
    }
  }
  
  _lastSubmitTime = DateTime.now();
  // ... rest of submit logic
});
```

## 🧪 Testing Best Practices

### Khi Develop:
1. **Dùng fake/mock repository** để test UI logic
2. **Disable email confirmation** trong Supabase
3. **Use local Supabase** cho unlimited testing
4. **Test với production** chỉ khi cần

### Production:
1. **Implement proper error handling** (đã làm ✅)
2. **Show clear messages** cho users
3. **Add analytics** để track rate limit errors
4. **Monitor** Supabase logs

## 📊 Monitoring Rate Limits

### Check Supabase Logs:
```
Dashboard → Logs → Filter: "rate limit"
```

### Add Analytics:
```dart
on<RegisterSubmitted>((event, emit) async {
  try {
    await _repository.registerWithEmail(...);
    // Track success
    analytics.logEvent('registration_success');
  } catch (e) {
    if (e.toString().contains('rate limit')) {
      // Track rate limit hit
      analytics.logEvent('registration_rate_limit');
    }
    // Track failure
    analytics.logEvent('registration_failure', parameters: {
      'error': e.toString()
    });
  }
});
```

## 🎯 Current Status

✅ **Error Handling**: Updated to catch 429 errors
✅ **User Message**: Shows friendly message
✅ **Code Quality**: Clean error handling

## 💡 Khuyến Nghị

**Cho Development:**
- Disable email confirmation trong Supabase settings
- Hoặc dùng local Supabase instance

**Cho Production:**
- Keep error handling như hiện tại
- Monitor rate limit errors
- Consider implementing retry logic nếu cần

**Immediate Action:**
- Đợi 1 giờ hoặc đổi IP/network
- Hoặc disable email confirmation trong Supabase để test

---

## 🔗 Links

- [Supabase Rate Limits Documentation](https://supabase.com/docs/guides/platform/going-into-prod#rate-limiting)
- [Supabase Local Development](https://supabase.com/docs/guides/cli/local-development)
- [Email Auth Configuration](https://supabase.com/docs/guides/auth/auth-email)
