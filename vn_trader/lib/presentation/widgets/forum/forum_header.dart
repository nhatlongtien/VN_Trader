import 'package:flutter/material.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/core/index.dart';

class ForumHeader extends StatelessWidget {
  const ForumHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(23)),
                border: Border.all(
                  color: AppColors.primaryLight,
                  width: 2
                )
              ),
            ),
            const Spacer(),
            Text(
              'Công đồng Trader VN',
              style: AppTextStyles.labelHeader
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
