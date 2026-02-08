import 'package:flutter/material.dart';
import 'package:vn_trader/core/router/app_router.dart';
import 'package:vn_trader/core/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://cyakurhqgqhgpwnxssgf.supabase.co',
    anonKey: 'sb_publishable_DsH1-zkVPgrNxY_6Ry8IKg_hpaOxa_2',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'VN Trader',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
