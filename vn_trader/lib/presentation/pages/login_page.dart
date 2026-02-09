import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vn_trader/presentation/bloc/login/login_bloc.dart';
import 'package:vn_trader/presentation/index.dart';
import 'package:vn_trader/presentation/widgets/login/login_form.dart';
import 'package:vn_trader/presentation/widgets/result_popup.dart';

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
        if (state.status == LoginStatus.validationError) {
          ResultPopup.showError(
            context: context,
            title: "Thông báo",
            message: "${state.errorMessage}",
            buttonText: "Đóng",
            onConfirm: () {
              Navigator.of(context).pop();
            },
          );
        }
        if (state.status == LoginStatus.success) {
          context.go('/tab');
        }
        if (state.status == LoginStatus.failure) {
          ResultPopup.showError(
            context: context,
            title: "Thông báo",
            message: "${state.errorMessage}",
            buttonText: "Đóng",
            onConfirm: () {
              Navigator.of(context).pop();
            },
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          // Unfocus textfield and hide keyboard when tapping anywhere
          FocusScope.of(context).unfocus();
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
                    const SizedBox(height: 32,),
                    Row(
                      children: [
                        Spacer(),
                        const Text(
                          'Vietnam Trader Community',
                          style: TextStyle(
                            fontSize: 18,
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
                    FocusScope.of(context).unfocus();
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
                        context.push('/register');
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
                    const SizedBox(height: 32),

                  ],
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
