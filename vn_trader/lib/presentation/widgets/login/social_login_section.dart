import 'package:flutter/material.dart';

class SocialLoginSection extends StatelessWidget {
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;

  const SocialLoginSection({
    super.key,
    required this.onGooglePressed,
    required this.onApplePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider with text
        Row(
          children: [
            Expanded(
              child: Container(
                height: 2,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/login/left_divider.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Or continue with',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF807A6B),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 2,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/login/right_divider.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        // Social Login Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google Button
            _SocialButton(
              icon: 'assets/images/login/logo.png',
              label: 'Google',
              onTap: onGooglePressed,
            ),
            const SizedBox(width: 20),
            // Apple Button
            _SocialButton(
              icon: 'assets/images/login/apple_icon.png',
              label: 'i0s',
              onTap: onApplePressed,
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(41.25),
          border: Border.all(
            color: const Color(0xFF75644B),
            width: 1,
          ),
        ),
        child: Material(
          color: const Color(0xFF27231B),
          borderRadius: BorderRadius.circular(41.25),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: Image.asset(
                  icon,
                  height: 35,
                  width: 35,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
