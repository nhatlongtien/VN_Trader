import 'package:flutter/material.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/core/theme/app_text_styles.dart';
import 'package:vn_trader/presentation/widgets/academy/index.dart';

class AcademyScreen extends StatelessWidget {
  const AcademyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AcademyScreenContent();
  }
}

class _AcademyScreenContent extends StatefulWidget {
  const _AcademyScreenContent();

  @override
  State<_AcademyScreenContent> createState() => _AcademyScreenContentState();
}

class _AcademyScreenContentState extends State<_AcademyScreenContent> {
  final List<LearningPath> _learningPaths = [
    LearningPath(
      title: 'Smart Money Concepts (SMC)',
      documentCount: '12 DOCUMENTS',
      completionRate: '85% COMPLETED',
      icon: Icons.account_balance,
      isNew: false,
      courses: [
        CourseItem(
          title: 'Market Structure Mastery',
          duration: '12 mins',
          level: 'Beginner',
          isFree: true,
        ),
        CourseItem(
          title: 'Liquidity & Inducement',
          duration: '24 mins',
          level: 'Advanced',
          isFavorite: true,
        ),
      ],
    ),
    LearningPath(
      title: 'Inner Circle Trader (ICT)',
      documentCount: '8 DOCUMENTS',
      completionRate: null,
      icon: Icons.timer,
      isNew: true,
      courses: [
        CourseItem(
          title: 'ICT Concepts Introduction',
          duration: '18 mins',
          level: 'Beginner',
          isFree: true,
        ),
        CourseItem(
          title: 'Optimal Trade Entry',
          duration: '32 mins',
          level: 'Advanced',
        ),
        CourseItem(
          title: 'Killzones & Sessions',
          duration: '28 mins',
          level: 'Intermediate',
        ),
      ],
    ),
    LearningPath(
      title: 'Elliott Wave Theory',
      documentCount: '15 DOCUMENTS',
      completionRate: null,
      icon: Icons.show_chart,
      isNew: false,
      courses: [
        CourseItem(
          title: 'Wave Patterns Basics',
          duration: '22 mins',
          level: 'Beginner',
        ),
        CourseItem(
          title: 'Impulse & Corrective Waves',
          duration: '35 mins',
          level: 'Advanced',
        ),
        CourseItem(
          title: 'Fibonacci & Wave Analysis',
          duration: '28 mins',
          level: 'Intermediate',
          isFree: true,
        ),
      ],
    ),
    LearningPath(
      title: 'Price Action Basics',
      documentCount: '20 DOCUMENTS',
      completionRate: null,
      icon: Icons.candlestick_chart,
      isNew: false,
      courses: [
        CourseItem(
          title: 'Support & Resistance',
          duration: '15 mins',
          level: 'Beginner',
          isFree: true,
        ),
        CourseItem(
          title: 'Candlestick Patterns',
          duration: '20 mins',
          level: 'Beginner',
          isFree: true,
        ),
        CourseItem(
          title: 'Trend Analysis',
          duration: '18 mins',
          level: 'Intermediate',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Column(
          children: [
            const Text(
              'Knowledge Base',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'VIETNAM TRADER ACADEMY',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Learning Paths List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _learningPaths.length,
              itemBuilder: (context, index) {
                final path = _learningPaths[index];
                return AcademyLearningPathCard(
                  title: path.title,
                  documentCount: path.documentCount,
                  completionRate: path.completionRate,
                  icon: path.icon,
                  isNew: path.isNew,
                  courses: path.courses,
                );
              },
            ),
            const SizedBox(height: 16),
            // Premium Section
            AcademyPremiumSection(
              onUpgrade: () {
                // Handle upgrade
                debugPrint('Upgrade to Premium tapped');
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class LearningPath {
  final String title;
  final String documentCount;
  final String? completionRate;
  final IconData icon;
  final bool isNew;
  final List<CourseItem> courses;

  LearningPath({
    required this.title,
    required this.documentCount,
    this.completionRate,
    required this.icon,
    this.isNew = false,
    required this.courses,
  });
}
