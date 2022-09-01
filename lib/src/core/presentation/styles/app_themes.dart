import 'package:flutter/material.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';

class AppTheme {
  static final ligthTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    inputDecorationTheme: inputDecorationTheme,
    textTheme: TextTheme(
      bodyMedium: AppTypography.mediumBodyTextStyle.copyWith(
        color: AppColors.lightPrimaryFontColor,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppColors.primarySwatch,
      accentColor: AppColors.accentColor,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
    ),
    inputDecorationTheme: inputDecorationTheme,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      accentColor: AppColors.accentColor,
      primarySwatch: AppColors.primarySwatch,
    ),
    textTheme: TextTheme(
      bodyMedium: AppTypography.mediumBodyTextStyle.copyWith(
        color: AppColors.darkPrimaryFontColor,
      ),
    ),
  );

  static final inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
