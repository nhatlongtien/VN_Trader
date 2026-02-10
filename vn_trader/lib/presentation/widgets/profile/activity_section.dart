import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_trader/core/theme/app_text_styles.dart';
import 'package:vn_trader/data/index.dart';
import 'package:vn_trader/presentation/bloc/profile/profile_bloc.dart';
import 'package:vn_trader/presentation/widgets/profile/action_tile.dart';

class ActivitySection extends StatelessWidget {
  final bool isAdmin;
  const ActivitySection({super.key, required this.isAdmin});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HOẠT ĐỘNG & TÀI KHOẢN',
          style: AppTextStyles.labelPrimary.copyWith(
            fontWeight: FontWeight.w700
          )
        ),
        const SizedBox(height: 12),
        ActionTile(
          icon: Icons.receipt_long_outlined,
          title: 'Lịch sử thanh toán',
          onTap: () =>
              context.read<ProfileBloc>().add(const ProfilePaymentHistoryPressed()),
        ),
        const SizedBox(height: 10),
        ActionTile(
          icon: Icons.bookmark_border,
          title: 'Bài viết đã lưu',
          onTap:
              () => context.read<ProfileBloc>().add(const ProfileSavedPostsPressed()),
        ),
        const SizedBox(height: 10),
        ActionTile(
          icon: Icons.show_chart_outlined,
          title: 'Tín hiệu đã theo dõi',
          onTap: () => context
              .read<ProfileBloc>()
              .add(const ProfileFollowedSignalsPressed()),
        ),
        const SizedBox(height: 10),
        ActionTile(
          icon: Icons.headset_mic_outlined,
          title: 'Trung tâm hỗ trợ',
          onTap: () =>
              context.read<ProfileBloc>().add(const ProfileSupportCenterPressed()),
        ),
        if (isAdmin) ...[
          const SizedBox(height: 10),
          ActionTile(
            icon: Icons.admin_panel_settings_outlined,
            title: 'Quản trị viên',
            onTap: () =>
                context.read<ProfileBloc>().add(const ProfileAdminPanelPressed()),
          ),
        ],
        const SizedBox(height: 10),
        ActionTile(
          icon: Icons.logout_rounded,
          title: 'Đăng xuất',
          titleColor: const Color(0xFFA7514E),
          onTap: () =>
              context.read<ProfileBloc>().add(const ProfileLogoutPressed()),
        ),
      ],
    );
  }
}
