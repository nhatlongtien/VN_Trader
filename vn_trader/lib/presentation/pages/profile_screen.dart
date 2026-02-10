import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/core/theme/app_text_styles.dart';
import 'package:vn_trader/data/index.dart';
import 'package:vn_trader/presentation/bloc/profile/profile_bloc.dart';
import 'package:vn_trader/presentation/widgets/profile/activity_section.dart';
import 'package:vn_trader/presentation/widgets/profile/membership_card.dart';
import 'package:vn_trader/presentation/widgets/profile/profile_header.dart';
import 'package:vn_trader/presentation/widgets/profile/stats_card.dart';

import '../../core/services/storage_service.dart';

class ProfileScreen extends StatefulWidget {
	const ProfileScreen({super.key});

	@override
	State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
	ProfileModel? userProfile;
	@override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    userProfile = await StorageService.getProfile();
		setState(() {

		});
  }

	@override
	Widget build(BuildContext context) {
		return BlocProvider(
			create: (context) => ProfileBloc(),
			child: BlocListener<ProfileBloc, ProfileState>(
				listenWhen: (previous, current) => previous.actionTick != current.actionTick,
				listener: (context, state) {
					switch (state.lastAction) {
						case ProfileAction.paymentHistory:
							context.push('/payment-history');
							break;
						case ProfileAction.adminPanel:
							context.push('/admin-dashboard');
							break;
						default:
							break;
					}
				},
				child: Scaffold(
					backgroundColor: AppColors.background,
					appBar: AppBar(
						backgroundColor: AppColors.background,
						elevation: 0,
						leadingWidth: 0,
						centerTitle: true,
						title: Text(
							'Hồ sơ cá nhân',
							style: AppTextStyles.labelHeader,
						),
						actions: [
							IconButton(
								icon: const Icon(
									Icons.settings,
									color: AppColors.iconPrimary,
								),
								onPressed: () {},
							),
						],
					),
					body: SafeArea(
						child: SingleChildScrollView(
							padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									const ProfileHeader(),
									const SizedBox(height: 18),
									const StatsCard(),
									const SizedBox(height: 18),
									const MembershipCard(),
									const SizedBox(height: 22),
									ActivitySection(isAdmin: userProfile?.isAdmin ?? false),
								],
							),
						),
					),
				),
			),
		);
	}
}
