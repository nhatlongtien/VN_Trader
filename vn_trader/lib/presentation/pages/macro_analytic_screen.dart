import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/core/theme/app_text_styles.dart';
import 'package:vn_trader/presentation/bloc/macro_analytic/macro_bloc.dart';
import 'package:vn_trader/presentation/widgets/macro_analytic/macro_category_filter.dart';
import 'package:vn_trader/presentation/widgets/macro_analytic/macro_post_card.dart';

class MacroAnalyticScreen extends StatefulWidget {
  const MacroAnalyticScreen({super.key});

  @override
  State<MacroAnalyticScreen> createState() => _MacroAnalyticScreenState();
}

class _MacroAnalyticScreenState extends State<MacroAnalyticScreen> {
  static const List<String> categories = [
    'All',
    'FED',
    'CPI',
    'Interest Rate',
    'GDP',
    'Other'
  ];

  late final List<MacroPost> _posts = [
    MacroPost(
      id: "1",
      author: "Tien Nguyen",
      title: "FED Meeting Outcomes: Navigating the 2024 Pivot",
      category: "All",
      date: "15 min ago",
      summary:
          "A deep dive into the latest Federal Reserve minutes and what they mean for the VNDyUSD..",
      imageUrl: "assets/images/login/forum_example_post.png",
      detailUrl: "",
    ),
    MacroPost(
      id: "1",
      author: "Tien Nguyen",
      title: "FED Meeting Outcomes: Navigating the 2024 Pivot",
      category: "All",
      date: "15 min ago",
      summary:
      "A deep dive into the latest Federal Reserve minutes and what they mean for the VNDyUSD..",
      imageUrl: "assets/images/login/forum_example_post.png",
      detailUrl: "",
    ),
    MacroPost(
      id: "1",
      author: "Tien Nguyen",
      title: "FED Meeting Outcomes: Navigating the 2024 Pivot",
      category: "All",
      date: "15 min ago",
      summary:
      "A deep dive into the latest Federal Reserve minutes and what they mean for the VNDyUSD..",
      imageUrl: "assets/images/login/forum_example_post.png",
      detailUrl: "",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MacroBloc(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Macro Market Analytic',
            style: AppTextStyles.labelHeader,
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),
            BlocBuilder<MacroBloc, MacroState>(
              builder: (context, state) {
                return MacroCategoryFilter(
                  categories: categories,
                  selectedCategory: state.selectedCategory,
                  onCategorySelected: (String category) {
                    context.read<MacroBloc>().add(
                      MacroCategoryChanged(category),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16,),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    final post = _posts[index];
                    return MacroPostCard(post: post, onTap: (){
                      print("Handle macro post tap");
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MacroPost {
  final String id;
  final String author;
  final String title;
  final String category;
  final String date;
  final String summary;
  final String imageUrl;
  final String detailUrl;

  MacroPost({
    required this.id,
    required this.author,
    required this.title,
    required this.category,
    required this.date,
    required this.summary,
    required this.imageUrl,
    required this.detailUrl,
  });
}
