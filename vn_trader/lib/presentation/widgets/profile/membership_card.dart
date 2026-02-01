import 'package:flutter/material.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/core/theme/app_text_styles.dart';

class MembershipCard extends StatelessWidget {
  const MembershipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1C2B22),
            Color(0xFF17251A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF334054),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF222F2B)),
                ),
                child: Text(
                  'Basic',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: const Color(0xFF919BA9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.emoji_events_outlined,
                color: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'HẠNG THÀNH VIÊN',
            style: AppTextStyles.labelSmall.copyWith(
              color: const Color(0xFF8F7B2C),
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Gói Miễn Phí',
            style: AppTextStyles.titleLarge.copyWith(
              color: const Color(0xFFD6D7D7),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Nâng cấp lên Premium để mở khóa các tín hiệu giao dịch VIP và các khóa học chuyên sâu từ chuyên gia.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: const Color(0xFF63717C),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD3AE36),
                foregroundColor: const Color(0xFF4C421F),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Color(0xFF977F2A)),
                ),
              ),
              child: Text(
                'NÂNG CẤP PREMIUM NGAY',
                style: AppTextStyles.titleSmall.copyWith(
                  color: const Color(0xFF4C421F),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
