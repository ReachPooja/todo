import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/src/core/presentation/theme/app_colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode()
      ..addListener(() {
        setState(() {});
      });
    passwordFocusNode = FocusNode()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              const Text(
                'Hello!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const Text(
                'Welcome to todo app',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const Spacer(),
              TextFormField(
                focusNode: emailFocusNode,
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                  labelText: 'Enter email',
                  floatingLabelStyle: TextStyle(
                    color: emailFocusNode.hasFocus
                        ? AppColors.accentColor
                        : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                focusNode: passwordFocusNode,
                decoration: InputDecoration(
                  labelText: 'Password',
                  floatingLabelStyle: TextStyle(
                    color: passwordFocusNode.hasFocus
                        ? AppColors.accentColor
                        : Colors.grey,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 54,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: const [
                  Expanded(
                    child: Divider(
                      endIndent: 10,
                      indent: 50,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Or',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      indent: 10,
                      color: Colors.grey,
                      endIndent: 50,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    side: const BorderSide(
                      color: AppColors.primaryColor,
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
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 3,
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Skip for now >>',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.accentColor,
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
