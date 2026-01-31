import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_trader/presentation/bloc/login/login_bloc.dart';
import 'package:vn_trader/presentation/index.dart';
import 'package:vn_trader/presentation/pages/forum_screen.dart';
import 'package:vn_trader/presentation/widgets/login/login_form.dart';
import 'package:vn_trader/presentation/widgets/login/social_login_section.dart';
import 'package:vn_trader/presentation/pages/welcome_screen.dart';
import 'package:vn_trader/presentation/pages/register_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LoginPageContent();
  }
}

class _LoginPageContent extends StatefulWidget {
  const _LoginPageContent({super.key});

  @override
  State<_LoginPageContent> createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<_LoginPageContent> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          Navigator.of(context).pushReplacement(
            // MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            MaterialPageRoute(builder: (context) => TabBarScreen()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF122017),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo
                    Row(
                      children: [
                        Spacer(),
                        const Text(
                          'Vietnam Trader Community',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD5D5D4),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                    const SizedBox(height: 40),
                    // Welcome Back Title
                    Center(
                      child: const Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE9E9E8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Subtitle
                    Center(
                      child: const Text(
                        'Access your dashboard and market insights.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF8F8977),
                        ),
                        textAlign: TextAlign.center,
                      ),

                    ),
                  ],
                ),
              ),
              // Login Form Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LoginForm(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  onEmailChanged: (email) {
                    context.read<LoginBloc>().add(LoginEmailChanged(email));
                  },
                  onPasswordChanged: (password) {
                    context.read<LoginBloc>().add(LoginPasswordChanged(password));
                  },
                  onLoginPressed: () {
                    context.read<LoginBloc>().add(const LoginSubmitted());
                  },
                ),
              ),
              const SizedBox(height: 30),
              // Forgot Password Link
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      // Handle forgot password
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFBC941F),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 45),
              // Social Login Section
              SocialLoginSection(
                onGooglePressed: () {
                  context.read<LoginBloc>().add(const LoginWithGooglePressed());
                },
                onApplePressed: () {
                  context.read<LoginBloc>().add(const LoginWithApplePressed());
                },
              ),
              const SizedBox(height: 44),
              // Create Account Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFF4F4937),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'New to the community?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8C8574),
                      ),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text(
                        'Create an Account',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC2991F),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
