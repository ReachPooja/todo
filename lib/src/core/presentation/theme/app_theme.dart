import 'package:flutter/material.dart';
import 'package:todo/src/core/presentation/theme/app_colors.dart';

class AppTheme {
  static final ligthTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.primaryBackgroundColor,
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryColor,
    ),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: AppColors.primaryColor,
    ),
  );
}
