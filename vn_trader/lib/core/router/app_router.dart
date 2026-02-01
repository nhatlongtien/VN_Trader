import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vn_trader/presentation/bloc/index.dart';
import 'package:vn_trader/presentation/bloc/macro_analytic/macro_bloc.dart';
import 'package:vn_trader/presentation/pages/index.dart';

/// Central GoRouter configuration for the app.
final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LoginBloc()),
          BlocProvider(create: (_) => CounterBloc()),
        ],
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/tab',
      builder: (context, state) => const TabBarScreen(),
    ),
    GoRoute(
      path: '/payment-history',
      builder: (context, state) => const PaymentHistoryScreen(),
    ),
    GoRoute(
      path: '/macro-analytic',
      builder: (context, state) => BlocProvider(
        create: (_) => MacroBloc()..add(const MacroInitialized()),
        child: const MacroAnalyticScreen(),
      ),
    ),
  ],
);
