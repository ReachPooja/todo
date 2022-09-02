import 'package:flutter/material.dart';
import 'package:todo/src/core/presentation/styles/app_colors.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: AppColors.primaryBackgroundColor,
      child: Center(
        child: Icon(
          Icons.task_outlined,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
