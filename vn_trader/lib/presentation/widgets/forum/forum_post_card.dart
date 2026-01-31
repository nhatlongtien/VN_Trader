import 'package:flutter/material.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/core/utils/image_helper.dart';
import 'package:vn_trader/presentation/pages/forum_screen.dart';
import 'package:vn_trader/presentation/widgets/forum/forum_signal_card.dart';

class ForumPostCard extends StatefulWidget {
  final ForumPost post;
  final VoidCallback onTap;

  const ForumPostCard({
    super.key,
    required this.post,
    required this.onTap,
  });

  @override
  State<ForumPostCard> createState() => _ForumPostCardState();
}

class _ForumPostCardState extends State<ForumPostCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // If it's a signal post with trading info
    if (widget.post.takeProfit != null && widget.post.stopLoss != null) {
      return ForumSignalCard(post: widget.post, onTap: widget.onTap);
    }

    // Regular post card
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.darkGreen1,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Header with author info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author avatar
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Author info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.post.authorName,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.post.timeAgo,
                          style: TextStyle(
                            color: AppColors.textSecondary.withValues(alpha: 0.6),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.more_horiz, color: AppColors.white, size: 20,)
                ],
              ),
            ),
            const Divider(
              color: AppColors.divider,
              height: 1,
              thickness: 1,
              indent: 12,
              endIndent: 12,
            ),
            // Post content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExpandableText(),
                  const SizedBox(height: 12),
                  
                  // Tags
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: widget.post.tags
                        .map((tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.border,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                tag,
                                style: const TextStyle(
                                  color: AppColors.textHint,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            const Divider(
              color: AppColors.divider,
              height: 1,
              thickness: 1,
              indent: 12,
              endIndent: 12,
            ),
            // Post footer with engagement stats
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat(Icons.thumb_up_outlined, widget.post.upvotes.toString()),
                  _buildStat(
                    Icons.message_outlined,
                    widget.post.comments.toString(),
                  ),
                  Icon(
                    Icons.share,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableText() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Tính toán số dòng thực tế khi hiển thị đầy đủ
        final fullTextPainter = TextPainter(
          text: TextSpan(
            text: widget.post.description,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12,
              height: 1.3,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        fullTextPainter.layout(maxWidth: constraints.maxWidth);

        // Tính số dòng
        final lines = fullTextPainter.computeLineMetrics().length;
        final hasMoreThan4Lines = lines > 4;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.description,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                height: 1.3,
              ),
              maxLines: _isExpanded ? null : 4,
              overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
            if (hasMoreThan4Lines)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Text(
                    _isExpanded ? 'Ẩn bớt' : 'Xem thêm',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 8,),
            ImageHelper.loadFromAsset(
              widget.post.authorImage,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
              radius: BorderRadius.circular(10)
            ),
          ],
        );
      },
    );
  }


  Widget _buildStat(IconData icon, String count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: AppColors.textSecondary,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          count,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
