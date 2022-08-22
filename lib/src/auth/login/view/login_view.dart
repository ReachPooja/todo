import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const primaryBackgroundColor = Color(0xfff5ebe0);
  static const primaryColor = Color(0xffd5bdaf);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: Column(
        children: [
          Text('Hello!'),
          Text('Welcome to todo app'),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter email',
            ),
          ),
        ],
      ),
    );
  }
}
