import 'package:flutter/material.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/core/theme/app_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.darkGreen2,
              border: Border.all(color: AppColors.border),
            ),
            child: const CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage('assets/images/login/forum_example_post.png'),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Trịnh Thế Hiển',
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 18
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          '@TrinhTrader88 • Tham gia 2023',
          style: AppTextStyles.labelSecondary,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
