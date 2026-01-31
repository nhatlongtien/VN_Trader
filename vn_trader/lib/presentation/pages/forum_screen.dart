import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/presentation/widgets/forum/forum_header.dart';
import 'package:vn_trader/presentation/widgets/forum/forum_category_filter.dart';
import 'package:vn_trader/presentation/widgets/forum/forum_post_card.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ForumScreenContent();
  }
}

class _ForumScreenContent extends StatefulWidget {
  const _ForumScreenContent();

  @override
  State<_ForumScreenContent> createState() => _ForumScreenContentState();
}

class _ForumScreenContentState extends State<_ForumScreenContent> {
  String _selectedCategory = 'Tất cả';
  final List<String> _categories = [
    'Tất cả',
    'VÀNG (XAU)',
    'FOREX',
    'SMC',
    'MỚI NHẤT'
  ];

  final List<ForumPost> _posts = [
    ForumPost(
      id: '2',
      authorName: 'Thanh Trader',
      authorImage: 'assets/images/login/forum_example_post.png',
      title:
          'Moi nguoi thuong lam gì khi gap chuoi thua 5-6 lenh lien tiep? Minh dang cam thay kha ap luc và muon bo cuφc...',
      description: 'Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi',
      timeAgo: '5 gio trudc',
      isPremium: false,
      isActive: false,
      upvotes: 156,
      comments: 89,
      views: 'XEM CHI TIẾT',
      tags: ['#TradingMindset', '#Psychology'],
      isFree: true,
    ),
    ForumPost(
      id: '3',
      authorName: 'Nguyen Trading',
      authorImage: 'assets/images/login/forum_example_post.png',
      title: 'Gold SMC Strategy cho phiên London hôm nay',
      description:
          'Cau truc thitruong tren H1 dang cuc ky bearish.\nHay chu y vung FVG chua duoc láp day truoc...',
      timeAgo: '2 gio trudc . Pro Trader',
      isPremium: true,
      isActive: false,
      upvotes: 42,
      comments: 124,
      views: 'XEM CHI TIẾT',
      tags: ['#XAUUSD', '#GOLD', '#SMC'],
      isFree: false,
    ),
    ForumPost(
      id: '2',
      authorName: 'Thanh Trader',
      authorImage: 'assets/images/login/forum_example_post.png',
      title:
      'Moi nguoi thuong lam gì khi gap chuoi thua 5-6 lenh lien tiep? Minh dang cam thay kha ap luc và muon bo cuφc...',
      description: 'Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi',
      timeAgo: '5 gio trudc',
      isPremium: false,
      isActive: false,
      upvotes: 156,
      comments: 89,
      views: 'XEM CHI TIẾT',
      tags: ['#TradingMindset', '#Psychology'],
      isFree: true,
    ),
    ForumPost(
      id: '2',
      authorName: 'Thanh Trader',
      authorImage: 'assets/images/login/forum_example_post.png',
      title:
      'Moi nguoi thuong lam gì khi gap chuoi thua 5-6 lenh lien tiep? Minh dang cam thay kha ap luc và muon bo cuφc...',
      description: 'Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi Thao luân ve tâm ly giao dich khi lo chuoi',
      timeAgo: '5 gio trudc',
      isPremium: false,
      isActive: false,
      upvotes: 156,
      comments: 89,
      views: 'XEM CHI TIẾT',
      tags: ['#TradingMindset', '#Psychology'],
      isFree: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: Container(),
        leadingWidth: 0,
        title: const ForumHeader(),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24,),
            const Divider(
              color: AppColors.divider,
              height: 1,
              thickness: 1,
            ),
            const SizedBox(height: 8,),
            // Posts List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return ForumPostCard(
                  post: _posts[index],
                  onTap: () {
                    // Handle post tap
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ForumPost {
  final String id;
  final String authorName;
  final String authorImage;
  final String title;
  final String description;
  final String timeAgo;
  final bool isPremium;
  final bool isActive;
  final int upvotes;
  final int comments;
  final String views;
  final String? takeProfit;
  final String? stopLoss;
  final List<String> tags;
  final bool isFree;

  ForumPost({
    required this.id,
    required this.authorName,
    required this.authorImage,
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.isPremium,
    required this.isActive,
    required this.upvotes,
    required this.comments,
    required this.views,
    this.takeProfit,
    this.stopLoss,
    required this.tags,
    required this.isFree,
  });
}
