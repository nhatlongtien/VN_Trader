import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/presentation/bloc/index.dart';
import 'package:vn_trader/presentation/widgets/signal/signal_card.dart';
import 'package:vn_trader/presentation/widgets/signal/signal_category_filter.dart';
import 'package:vn_trader/presentation/widgets/signal/signal_header.dart';

class SignalScreen extends StatefulWidget {
  const SignalScreen({super.key});

  @override
  State<SignalScreen> createState() => _SignalScreenState();
}

class _SignalScreenState extends State<SignalScreen> {
  static const List<String> categories = [
    'All',
    'Crypto',
    'Forex',
    'Gold',
    'Stock'
  ];

  late List<SignalPost> _post = [
    SignalPost(
      id: '1',
      authorName: 'Signal Bot AI',
      authorImage: 'assets/images/placeholder.png',
      title: 'BUY EUR/USD',
      timeAgo: '5 hours ago',
      isPremium: true,
      isActive: true,
      upVotes: 23,
      comments: 412,
      views: 'VIEW DETAILS',
      entryPrice: '1.08500',
      takeProfit: '1.09100',
      stopLoss: '1.08200',
      isFree: false,
    ),
    SignalPost(
      id: '1',
      authorName: 'Signal Bot AI',
      authorImage: 'assets/images/placeholder.png',
      title: 'BUY EUR/USD',
      timeAgo: '5 hours ago',
      isPremium: true,
      isActive: true,
      upVotes: 23,
      comments: 412,
      views: 'VIEW DETAILS',
      entryPrice: '1.08500',
      takeProfit: '1.09100',
      stopLoss: '1.08200',
      isFree: false,
    ),
    SignalPost(
      id: '1',
      authorName: 'Signal Bot AI',
      authorImage: 'assets/images/placeholder.png',
      title: 'BUY EUR/USD',
      timeAgo: '5 hours ago',
      isPremium: true,
      isActive: true,
      upVotes: 23,
      comments: 412,
      views: 'VIEW DETAILS',
      entryPrice: '1.08500',
      takeProfit: '1.09100',
      stopLoss: '1.08200',
      isFree: false,
    ),
    SignalPost(
      id: '1',
      authorName: 'Signal Bot AI',
      authorImage: 'assets/images/placeholder.png',
      title: 'BUY EUR/USD',
      timeAgo: '5 hours ago',
      isPremium: true,
      isActive: true,
      upVotes: 23,
      comments: 412,
      views: 'VIEW DETAILS',
      entryPrice: '1.08500',
      takeProfit: '1.09100',
      stopLoss: '1.08200',
      isFree: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignalBloc()..add(const SignalInitialized()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: Container(),
          leadingWidth: 0,
          title: const SignalHeader(),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16,),
              BlocBuilder<SignalBloc, SignalState>(
                builder: (context, state) {
                  return SignalCategoryFilter(
                    categories: categories,
                    selectedCategory: state.selectedCategory,
                    onCategorySelected: (String category) {
                      context.read<SignalBloc>().add(SignalCategoryChanged(category));
                    },
                  );
                },
              ),
              const SizedBox(height: 24,),
              const Divider(
                color: AppColors.divider,
                height: 1,
                thickness: 1,
              ),
              const SizedBox(height: 8,),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _post.length,
                itemBuilder: (context, index) {
                  return SignalCard(
                    post: _post[index],
                    onTap: () {
                      // Handle post tap
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}


class SignalPost {
  final String id;
  final String authorName;
  final String authorImage;
  final String title;
  final String timeAgo;
  final bool isPremium;
  final bool isActive;
  final int upVotes;
  final int comments;
  final String views;
  final String? entryPrice;
  final String? takeProfit;
  final String? stopLoss;
  final bool isFree;

  SignalPost({
    required this.id,
    required this.authorName,
    required this.authorImage,
    required this.title,
    required this.timeAgo,
    required this.isPremium,
    required this.isActive,
    required this.upVotes,
    required this.comments,
    required this.views,
    this.entryPrice,
    this.takeProfit,
    this.stopLoss,
    required this.isFree,
  });
}
