import 'package:flutter/material.dart';
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
        // backgroundColor: AppColors.primaryBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              const SizedBox(
                height: 24,
              ),
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
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 20,
                    ),
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
