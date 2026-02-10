import 'package:flutter/material.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/core/theme/app_text_styles.dart';
import 'package:vn_trader/presentation/widgets/admin/stats_card_widget.dart';
import 'package:vn_trader/presentation/widgets/admin/revenue_chart_widget.dart';
import 'package:vn_trader/presentation/widgets/admin/quick_action_card.dart';
import 'package:vn_trader/presentation/widgets/admin/activity_item.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admin Dashboard',
                style: AppTextStyles.labelHeader,
              ),
            ],
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.iconPrimary,
                  size: 26,
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Cards Row
              Row(
                children: [
                  Expanded(
                    child: StatsCardWidget(
                      title: 'Total Users',
                      value: '12,450',
                      percentage: '+6.2%',
                      icon: Icons.people,
                      isPositive: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatsCardWidget(
                      title: 'Premium',
                      value: '1,205',
                      percentage: '+2.1%',
                      icon: Icons.workspace_premium,
                      isPositive: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Revenue Chart
              const RevenueChartWidget(),
              const SizedBox(height: 24),

              // Quick Actions Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quick Actions',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'SEE ALL',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Quick Action Cards Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: [
                  QuickActionCard(
                    icon: Icons.people_outline,
                    iconColor: const Color(0xFF5B8CFF),
                    iconBgColor: const Color(0xFF5B8CFF).withValues(alpha: 0.15),
                    title: 'Manage Users',
                    subtitle: 'Add & Permissions',
                    onTap: () {},
                  ),
                  QuickActionCard(
                    icon: Icons.article_outlined,
                    iconColor: const Color(0xFFFFAB40),
                    iconBgColor: const Color(0xFFFFAB40).withValues(alpha: 0.15),
                    title: 'Content',
                    subtitle: 'News & Tutorials',
                    onTap: () {},
                  ),
                  QuickActionCard(
                    icon: Icons.trending_up,
                    iconColor: AppColors.primary,
                    iconBgColor: AppColors.primary.withValues(alpha: 0.15),
                    title: 'Post Signals',
                    subtitle: 'Trade Alerts',
                    onTap: () {

                    },
                  ),
                  QuickActionCard(
                    icon: Icons.bar_chart,
                    iconColor: const Color(0xFFAB7AFF),
                    iconBgColor: const Color(0xFFAB7AFF).withValues(alpha: 0.15),
                    title: 'Reports',
                    subtitle: 'Analytics',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Recent Activity Section
              Text(
                'Recent Activity',
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),

              // Activity Items
              ActivityItem(
                icon: Icons.shopping_cart,
                iconBgColor: AppColors.primary.withValues(alpha: 0.15),
                iconColor: AppColors.primary,
                title: 'New Premium Subscription',
                subtitle: 'user@email.com subscribed',
                timeAgo: '2m ago',
              ),
              ActivityItem(
                icon: Icons.show_chart,
                iconBgColor: const Color(0xFFFFAB40).withValues(alpha: 0.15),
                iconColor: const Color(0xFFFFAB40),
                title: 'Signal Posted: BTC/USDT',
                subtitle: 'Admin XYZ published new signal',
                timeAgo: '15m ago',
              ),
              ActivityItem(
                icon: Icons.person_add,
                iconBgColor: const Color(0xFF5B8CFF).withValues(alpha: 0.15),
                iconColor: const Color(0xFF5B8CFF),
                title: 'New User Registered',
                subtitle: 'newuser@email.com joined',
                timeAgo: '40m ago',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
