import 'package:flutter/material.dart';
import 'package:vn_trader/core/constants/app_colors.dart';

enum ResultPopupType {
  success,
  error,
}

/// Reusable popup component for showing success/error feedback
/// Can be used for registration, payment, course completion, etc.
class ResultPopup extends StatelessWidget {
  final ResultPopupType type;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onConfirm;

  const ResultPopup({
    super.key,
    required this.type,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final isSuccess = type == ResultPopupType.success;
    final primaryColor = isSuccess ? AppColors.primary : Colors.red;
    final iconColor = isSuccess ? AppColors.primary : Colors.red.shade400;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.backgroundDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSuccess ? AppColors.primary.withValues(alpha: 0.3) : Colors.red.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor.withValues(alpha: 0.15),
                border: Border.all(
                  color: iconColor.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                isSuccess ? Icons.check_rounded : Icons.close_rounded,
                size: 48,
                color: iconColor,
              ),
            ),
            const SizedBox(height: 24),
            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            // Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show success popup
  static Future<void> showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ResultPopup(
        type: ResultPopupType.success,
        title: title,
        message: message,
        buttonText: buttonText,
        onConfirm: onConfirm,
      ),
    );
  }

  /// Show error popup
  static Future<void> showError({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ResultPopup(
        type: ResultPopupType.error,
        title: title,
        message: message,
        buttonText: buttonText,
        onConfirm: onConfirm,
      ),
    );
  }
}
