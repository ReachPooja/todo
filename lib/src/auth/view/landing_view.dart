import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/src/auth/view/email_auth_view.dart';
import 'package:todo/src/auth/view/widgets/skip_dialog.dart';
import 'package:todo/src/core/presentation/theme/app_colors.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Hello!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  letterSpacing: 1.5,
                ),
              ),
              const Text(
                'Welcome to todo app',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Expanded(
                child: SvgPicture.asset(
                  isDarkMode
                      ? 'assets/images/landing_dark.svg'
                      : 'assets/images/landing.svg',
                  height: MediaQuery.of(context).size.height / 4,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push<EmailAuthView>(
                      MaterialPageRoute(
                        builder: (_) => const EmailAuthView(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  icon: const Icon(
                    Icons.email_outlined,
                  ),
                  label: const Text(
                    'Continue with Email',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    primary: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  icon: SvgPicture.asset(
                    'assets/icons/google.svg',
                    height: 20,
                  ),
                  label: const Text(
                    'Continue with Google',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 24,
                  bottom: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        endIndent: 10,
                        indent: 80,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Text(
                      'Or',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        indent: 10,
                        color: Colors.grey.shade400,
                        endIndent: 80,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  await skipDialog(context, isDarkMode: isDarkMode);
                },
                style: TextButton.styleFrom(
                  primary: AppColors.accentColor,
                ),
                child: const Text(
                  'Skip for now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
