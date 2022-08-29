import 'package:flutter/material.dart';
import 'package:todo/src/core/presentation/theme/app_colors.dart';

class AppTheme {
  static final ligthTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryColor,
    ),
    textSelectionTheme: textSelectionTheme,
    inputDecorationTheme: inputDecorationTheme,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: AppColors.accentColor,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    fontFamily: 'Poppins',
    textSelectionTheme: textSelectionTheme,
    inputDecorationTheme: inputDecorationTheme,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      accentColor: AppColors.accentColor,
    ),
  );

  static const textSelectionTheme = TextSelectionThemeData(
    cursorColor: AppColors.primaryColor,
    selectionHandleColor: AppColors.primaryColor,
    selectionColor: AppColors.primaryBackgroundColor,
  );

  static final inputDecorationTheme = InputDecorationTheme(
    floatingLabelStyle: const TextStyle(
      color: AppColors.accentColor,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Colors.grey.shade300,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.accentColor,
      ),
    ),
  );
}
