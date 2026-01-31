import 'package:flutter/material.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/presentation/index.dart';
import 'package:vn_trader/presentation/pages/signal_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  int _currentIndex = 0;
  final PageController _pageController =
  PageController(initialPage: 0);

  ///Screen cycle
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  Widget _buildNavItem(int index, String label, String icon, String selectedIcon) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
          _pageController.jumpToPage(index);
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Image.asset(
              isSelected ? selectedIcon : icon,
              width: 24,
              height: 24,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w400 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  /// UI
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children:  [
            ForumScreen(),
            ForumScreen(),
            SignalScreen(),
            ForumScreen(),
          ],

        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: AppColors.darkGreen1,
            border: Border(
              top: BorderSide(color: AppColors.border, width: 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, 'Forum', 'assets/images/login/forum_ic.png', 'assets/images/login/forum_selected_ic.png'),
              _buildNavItem(1, 'Education', 'assets/images/login/academy_ic.png', 'assets/images/login/academy_selected_ic.png'),
              _buildNavItem(2, 'Signal', 'assets/images/login/signal_ic.png', 'assets/images/login/signal_selected_ic.png'),
              _buildNavItem(3, 'Profile', 'assets/images/login/profile_ic.png', 'assets/images/login/profile_selected_ic.png'),
            ],
          ),
        ),
      ),
    );
  }
}
