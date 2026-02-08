# ResultPopup - Quick Reference Guide

## 📦 Import
```dart
import 'package:vn_trader/presentation/widgets/result_popup.dart';
```

---

## ✅ Success Popup

### Basic Usage
```dart
ResultPopup.showSuccess(
  context: context,
  title: 'Success Title',
  message: 'Your success message here',
  buttonText: 'OK',
  onConfirm: () {
    Navigator.of(context).pop(); // Close the popup
  },
);
```

### Example: Registration Success
```dart
ResultPopup.showSuccess(
  context: context,
  title: 'Tài khoản đã sẵn sàng!',
  message: 'Chào mừng bạn đến với cộng đồng Trader Việt Nam. Hãy bắt đầu hành trình giao dịch của bạn ngay bây giờ.',
  buttonText: 'Bắt đầu ngay',
  onConfirm: () {
    Navigator.of(context).pop(); // Close popup
    Navigator.of(context).pop(); // Go back to login
  },
);
```

### Example: Payment Success
```dart
ResultPopup.showSuccess(
  context: context,
  title: 'Thanh toán thành công!',
  message: 'Giao dịch của bạn đã được xử lý. Cảm ơn bạn đã tin tưởng sử dụng dịch vụ.',
  buttonText: 'Xem chi tiết',
  onConfirm: () {
    Navigator.of(context).pop(); // Close popup
    Navigator.pushNamed(context, '/transaction-details');
  },
);
```

### Example: Course Completion
```dart
ResultPopup.showSuccess(
  context: context,
  title: 'Chúc mừng hoàn thành!',
  message: 'Bạn đã hoàn thành khóa học. Chứng chỉ của bạn đã sẵn sàng để tải xuống.',
  buttonText: 'Tải chứng chỉ',
  onConfirm: () {
    Navigator.of(context).pop();
    // Download certificate logic
  },
);
```

---

## ❌ Error Popup

### Basic Usage
```dart
ResultPopup.showError(
  context: context,
  title: 'Error Title',
  message: 'Your error message here',
  buttonText: 'Retry',
  onConfirm: () {
    Navigator.of(context).pop(); // Close the popup
  },
);
```

### Example: Registration Error
```dart
ResultPopup.showError(
  context: context,
  title: 'Đăng ký thất bại',
  message: state.errorMessage ?? 'Đã xảy ra lỗi trong quá trình tạo tài khoản. Vui lòng thử lại.',
  buttonText: 'Thử lại',
  onConfirm: () {
    Navigator.of(context).pop(); // Just close popup, stay on page
  },
);
```

### Example: Network Error
```dart
ResultPopup.showError(
  context: context,
  title: 'Lỗi kết nối',
  message: 'Không thể kết nối đến máy chủ. Vui lòng kiểm tra kết nối internet của bạn.',
  buttonText: 'Thử lại',
  onConfirm: () {
    Navigator.of(context).pop();
    // Retry logic
  },
);
```

### Example: Validation Error
```dart
ResultPopup.showError(
  context: context,
  title: 'Dữ liệu không hợp lệ',
  message: 'Vui lòng kiểm tra lại thông tin đã nhập và thử lại.',
  buttonText: 'Đóng',
  onConfirm: () {
    Navigator.of(context).pop();
  },
);
```

---

## 🎨 Customization

### With Dynamic Message
```dart
final errorMessage = exception.toString().replaceAll('Exception: ', '');

ResultPopup.showError(
  context: context,
  title: 'Có lỗi xảy ra',
  message: errorMessage.isEmpty 
    ? 'Đã xảy ra lỗi không xác định. Vui lòng thử lại sau.'
    : errorMessage,
  buttonText: 'Thử lại',
  onConfirm: () => Navigator.of(context).pop(),
);
```

### With Multiple Actions
```dart
ResultPopup.showSuccess(
  context: context,
  title: 'Đăng bài thành công!',
  message: 'Bài viết của bạn đã được đăng tải.',
  buttonText: 'Xem bài viết',
  onConfirm: () {
    Navigator.of(context).pop(); // Close popup
    Navigator.pushNamed(context, '/post-details', arguments: postId);
  },
);
```

---

## 🔧 Advanced Usage

### With BLoC Pattern
```dart
BlocListener<RegisterBloc, RegisterState>(
  listener: (context, state) {
    if (state.showPopup) {
      context.read<RegisterBloc>().add(RegisterPopupShown());
      
      if (state.registerSuccess && state.insertUserSuccess) {
        ResultPopup.showSuccess(
          context: context,
          title: 'Success!',
          message: 'Operation completed',
          buttonText: 'Continue',
          onConfirm: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      } else {
        ResultPopup.showError(
          context: context,
          title: 'Failed',
          message: state.errorMessage ?? 'Unknown error',
          buttonText: 'Retry',
          onConfirm: () => Navigator.of(context).pop(),
        );
      }
    }
  },
  child: YourWidget(),
)
```

### With Async Operations
```dart
onConfirm: () async {
  Navigator.of(context).pop(); // Close popup first
  
  // Show loading
  showDialog(
    context: context,
    builder: (context) => LoadingDialog(),
  );
  
  // Perform async operation
  await performSomeOperation();
  
  // Navigate
  Navigator.pushNamed(context, '/next-screen');
},
```

---

## 📝 Best Practices

### ✅ DO:
- Use descriptive titles and messages
- Provide clear action button text
- Handle popup dismissal properly
- Use appropriate type (success/error)
- Keep messages concise and user-friendly

### ❌ DON'T:
- Don't use technical error messages for users
- Don't forget to close the popup in onConfirm
- Don't use generic messages like "Error" or "Success"
- Don't nest multiple popups
- Don't make barrierDismissible true (currently disabled by design)

---

## 🎯 Common Use Cases

| Use Case | Type | Example Title |
|----------|------|---------------|
| Registration | Success | Tài khoản đã sẵn sàng! |
| Login Error | Error | Đăng nhập thất bại |
| Payment Success | Success | Thanh toán thành công! |
| Upload Complete | Success | Tải lên hoàn tất! |
| Network Error | Error | Lỗi kết nối |
| Validation Error | Error | Dữ liệu không hợp lệ |
| Delete Confirmation | Success | Đã xóa thành công |
| Update Profile | Success | Cập nhật thành công! |

---

## 🔍 Troubleshooting

### Popup not showing?
- Check if `context` is valid
- Ensure popup is called after widget is built
- Check if there's another dialog already showing

### Multiple popups appearing?
- Use a flag (like `showPopup`) to control display
- Reset flag after showing popup
- Use `barrierDismissible: false` to prevent accidental dismissals

### Navigation not working?
- Always call `Navigator.of(context).pop()` first to close popup
- Then perform other navigation
- Check if context is still valid

---

## 💡 Tips

1. **Localization Ready**: All text is passed as parameters, easy to localize
2. **Consistent Design**: Uses app theme colors automatically
3. **Reusable**: Works across the entire app
4. **Type Safe**: Uses enum for popup type
5. **Flexible**: Can handle any navigation or action in `onConfirm`

---

## 📚 Related Files

- Widget: `lib/presentation/widgets/result_popup.dart`
- Usage Example: `lib/presentation/pages/register_screen.dart`
- Documentation: `POST_REGISTRATION_FLOW.md`
