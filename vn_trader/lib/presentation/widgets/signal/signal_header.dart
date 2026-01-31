import 'package:flutter/material.dart';
import 'package:vn_trader/core/index.dart';
import 'package:vn_trader/core/utils/image_helper.dart';

class SignalHeader extends StatelessWidget {
  const SignalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ImageHelper.loadFromAsset(
              "assets/images/login/signal_logo_header.png",
              width: 60,
              height: 48,

            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Trading Signal',
                    style: AppTextStyles.labelHeader
                ),
                const SizedBox(height: 4,),
                Row(
                  children: [
                    Icon(Icons.circle, color: AppColors.primary, size: 14,),
                    const SizedBox(width: 8,),
                    Text(
                        'LIVE MARKET',
                        style: TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.w300)
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            ImageHelper.loadFromAsset(
              "assets/images/login/filter_ic.png",
              width: 45,
              height: 45,
            )
          ],
        ),
      ],
    );
  }
}