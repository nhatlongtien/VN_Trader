import 'package:flutter/material.dart';
import 'package:vn_trader/core/constants/app_colors.dart';

class StatsDivider extends StatelessWidget {
  const StatsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 48,
      color: AppColors.border,
      margin: const EdgeInsets.symmetric(horizontal: 12),
    );
  }
}
