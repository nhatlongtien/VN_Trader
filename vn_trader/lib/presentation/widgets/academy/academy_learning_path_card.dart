import 'package:flutter/material.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/core/theme/app_text_styles.dart';
import 'package:vn_trader/presentation/widgets/academy/academy_course_item.dart';

class AcademyLearningPathCard extends StatefulWidget {
  final String title;
  final String documentCount;
  final String? completionRate;
  final IconData icon;
  final bool isNew;
  final List<CourseItem> courses;

  const AcademyLearningPathCard({
    super.key,
    required this.title,
    required this.documentCount,
    this.completionRate,
    required this.icon,
    this.isNew = false,
    required this.courses,
  });

  @override
  State<AcademyLearningPathCard> createState() =>
      _AcademyLearningPathCardState();
}

class _AcademyLearningPathCardState extends State<AcademyLearningPathCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.darkGreen2.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Icon
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      widget.icon,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.title,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            // if (widget.isNew)
                            //   Container(
                            //     margin: const EdgeInsets.only(left: 8),
                            //     padding: const EdgeInsets.symmetric(
                            //       horizontal: 6,
                            //       vertical: 2,
                            //     ),
                            //     decoration: BoxDecoration(
                            //       color: AppColors.primary,
                            //       borderRadius: BorderRadius.circular(4),
                            //     ),
                            //     child: const Text(
                            //       'NEW',
                            //       style: TextStyle(
                            //         color: AppColors.background,
                            //         fontSize: 9,
                            //         fontWeight: FontWeight.w700,
                            //       ),
                            //     ),
                            //   ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              widget.documentCount,
                              style: TextStyle(
                                color: AppColors.textSecondary.withOpacity(0.7),
                                fontSize: 10,
                              ),
                            ),
                            if (widget.completionRate != null) ...[
                              const SizedBox(width: 8),
                              Container(
                                width: 3,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: AppColors.textSecondary.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.completionRate!,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Expand Icon
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.textSecondary,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          // Expanded Content
          if (_isExpanded && widget.courses.isNotEmpty)
            Container(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                children: widget.courses
                    .map((course) => AcademyCourseItem(
                          title: course.title,
                          duration: course.duration,
                          level: course.level,
                          isFree: course.isFree,
                          isFavorite: course.isFavorite,
                          onTap: course.onTap,
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class CourseItem {
  final String title;
  final String duration;
  final String level;
  final bool isFree;
  final bool isFavorite;
  final VoidCallback? onTap;

  CourseItem({
    required this.title,
    required this.duration,
    required this.level,
    this.isFree = false,
    this.isFavorite = false,
    this.onTap,
  });
}
