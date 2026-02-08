import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_trader/core/constants/app_colors.dart';
import 'package:vn_trader/presentation/bloc/register/register_bloc.dart';
import 'package:vn_trader/presentation/bloc/register/register_event.dart';
import 'package:vn_trader/presentation/bloc/register/register_state.dart';
import 'package:vn_trader/presentation/widgets/result_popup.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: const _RegisterScreenContent(),
    );
  }
}

class _RegisterScreenContent extends StatefulWidget {
  const _RegisterScreenContent();

  @override
  State<_RegisterScreenContent> createState() => _RegisterScreenContentState();
}

class _RegisterScreenContentState extends State<_RegisterScreenContent> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreed = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        // Only show popup once when showPopup is true
        if (state.showPopup) {
          // Mark popup as shown
          context.read<RegisterBloc>().add(RegisterPopupShown());

          // Check if both register and insert were successful
          if (state.registerSuccess && state.insertUserSuccess) {
            // SUCCESS CASE: Show success popup
            ResultPopup.showSuccess(
              context: context,
              title: 'Tài khoản đã sẵn sàng!',
              message: 'Chào mừng bạn đến với cộng đồng Trader Việt Nam. Hãy bắt đầu hành trình giao dịch của bạn ngay bây giờ.',
              buttonText: 'Bắt đầu ngay',
              onConfirm: () {
                // Close popup
                Navigator.of(context).pop();
                // Navigate to login screen
                Navigator.of(context).pop();
              },
            );
          } else {
            // ERROR CASE: Show error popup
            ResultPopup.showError(
              context: context,
              title: 'Đăng ký thất bại',
              message: state.errorMessage ?? 'Đã xảy ra lỗi trong quá trình tạo tài khoản. Vui lòng thử lại.',
              buttonText: 'Thử lại',
              onConfirm: () {
                // Close popup and stay on registration screen
                Navigator.of(context).pop();
              },
            );
          }
        }
      },
      child: Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Create Account',
          style: TextStyle(color: AppColors.white, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              'Join the Community',
              style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Connect with the top traders in Vietnam.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
            const SizedBox(height: 32),
            _buildTextField(
              controller: _fullNameController,
              label: 'Full Name',
              hint: 'Enter your full name',
              keyboardType: TextInputType.name,
              obscure: false,
              onChanged: (value) {
                context.read<RegisterBloc>().add(RegisterFullNameChanged(value));
              },
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              hint: 'example@email.com',
              keyboardType: TextInputType.emailAddress,
              obscure: false,
              onChanged: (value) {
                context.read<RegisterBloc>().add(RegisterEmailChanged(value));
              },
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _passwordController,
              label: 'Password',
              hint: 'Create a strong password',
              keyboardType: TextInputType.visiblePassword,
              obscure: _obscurePassword,
              onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
              onChanged: (value) {
                context.read<RegisterBloc>().add(RegisterPasswordChanged(value));
              },
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _confirmPasswordController,
              label: 'Confirm Password',
              hint: 'Repeat your password',
              keyboardType: TextInputType.visiblePassword,
              obscure: _obscureConfirmPassword,
              onToggleObscure: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
              onChanged: (value) {
                context.read<RegisterBloc>().add(RegisterConfirmPasswordChanged(value));
              },
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _agreed,
                  onChanged: (v) {
                    setState(() => _agreed = v ?? false);
                    context.read<RegisterBloc>().add(RegisterTermsToggled(v ?? false));
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                      children: [
                        const TextSpan(text: 'I agree to the '),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: const TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w500, color: AppColors.primaryDark),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // TODO: Navigate to Terms
                            },
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w500, color: AppColors.primaryDark),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // TODO: Navigate to Privacy
                            },
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: state.isSubmitting
                        ? null
                        : () {
                            context.read<RegisterBloc>().add(RegisterSubmitted());
                          },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
                    ),
                    child: state.isSubmitting
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: AppColors.backgroundDark,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Register Now',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.backgroundDark),
                          ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    'Login',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 14)
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Social Login Section
            // SocialLoginSection(
            //   onGooglePressed: () {/* TODO: Google sign up */},
            //   onApplePressed: () {/* TODO: Apple sign up */},
            // ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required TextInputType keyboardType,
    required bool obscure,
    VoidCallback? onToggleObscure,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w400, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: TextStyle(color: AppColors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.textHint, fontSize: 13),
            fillColor: AppColors.textFieldBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(
                color: Color(0xFF718478),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(
                color: Color(0xFF718478),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(
                color: Color(0xFF27904F),
                width: 1,
              ),
            ),
            suffixIcon: onToggleObscure != null
                ? IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textHint,
                    ),
                    onPressed: onToggleObscure,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
