import 'package:flutter/material.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/presentation/widgets/profile/stat_item.dart';
import 'package:vn_trader/presentation/widgets/profile/stats_divider.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.textFieldBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: const [
          Expanded(
            child: StatItem(
              label: 'BÀI VIẾT',
              value: '128',
            ),
          ),
          StatsDivider(),
          Expanded(
            child: StatItem(
              label: 'THEO DÕI',
              value: '1.2k',
            ),
          ),
          StatsDivider(),
          Expanded(
            child: StatItem(
              label: 'WIN RATE',
              value: '85%',
            ),
          ),
        ],
      ),
    );
  }
}
