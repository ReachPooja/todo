import 'package:flutter/material.dart';
import 'package:todo/src/core/presentation/layout/constants.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';

class AppTheme {
  static final ligthTheme = ThemeData(
    brightness: Brightness.light,
    // scaffoldBackgroundColor: Colors.grey.shade200,
    primaryColor: AppColors.primaryColor,
    fontFamily: AppTypography.fontFamily,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    // inputDecorationTheme: inputDecorationTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    textButtonTheme: textButtonTheme,
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
    fontFamily: AppTypography.fontFamily,
    // inputDecorationTheme: inputDecorationTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    textButtonTheme: textButtonTheme,
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

  static const inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: Constants.smallBorderRadius,
    ),
  );

  static final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: Constants.smallBorderRadius,
      ),
    ),
  );
  static final outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: Constants.smallBorderRadius,
      ),
      side: const BorderSide(
        color: AppColors.primaryColor,
      ),
    ),
  );
  static final textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.accentColor,
    ),
  );
}
