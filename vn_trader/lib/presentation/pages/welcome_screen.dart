import 'package:flutter/material.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/core/theme/app_text_styles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2620),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 125),
            // Logo
            Center(
              child: Image.asset(
                'assets/images/login/logo.png',
                width: 120,
                height: 120,
              ),
            ),
            const SizedBox(height: 32),
            // VIETNAM
            Center(
              child: Text(
                'VIETNAM',
                style: AppTextStyles.displaySmall.copyWith(
                  color: const Color(0xFFC7C8C4),
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ),
            // TRADER
            Center(
              child: Text(
                'TRADER',
                style: AppTextStyles.displaySmall.copyWith(
                  color: const Color(0xFF37CE6E),
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ),
            // COMMUNITY
            Center(
              child: Text(
                'COMMUNITY',
                style: AppTextStyles.displaySmall.copyWith(
                  color: const Color(0xFFDEDDDB),
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ),
            Spacer(),
            // EMPOWERING TRADERS
            Center(
              child: Text(
                'EMPOWERING TRADERS',
                style: AppTextStyles.titleLarge.copyWith(
                  color: const Color(0xFF276C3B),
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Version
            Center(
              child: Text(
                'VERSION 2.4.0',
                style: AppTextStyles.bodySmall.copyWith(
                  color: const Color(0xFF383B36),
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
