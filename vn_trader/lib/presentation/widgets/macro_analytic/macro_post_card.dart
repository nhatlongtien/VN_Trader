import 'package:flutter/material.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/core/utils/image_helper.dart';
import 'package:vn_trader/presentation/index.dart';

class MacroPostCard extends StatelessWidget {
  const MacroPostCard({super.key, required this.post, required this.onTap});
  final MacroPost post;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.darkGreen2,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageHelper.loadFromAsset(
                  post.imageUrl,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  radius: BorderRadius.circular(10)
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      post.date,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Text(
                  post.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  post.summary,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16,),
                Row(
                  children: [
                    ImageHelper.loadFromAsset(
                        "assets/images/login/profile_ic.png",
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                      radius: BorderRadius.circular(16)
                    ),
                    const SizedBox(width: 8),
                    Text(
                      post.author,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.add_moderator, color: AppColors.primary,)
                  ],
                )
              ],
            ),
          ),
        ),

      ],
    );
  }
}
