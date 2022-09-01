import 'package:flutter/material.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';

extension ThemeX on ThemeData {
  // Current brightness of the app
  bool get isDark => brightness == Brightness.dark;

  // Primary font color
  Color get primaryFontColor =>
      isDark ? AppColors.darkPrimaryFontColor : AppColors.lightPrimaryFontColor;

  // Secondary font color
  Color get secondaryFontColor => isDark
      ? AppColors.darkSecondaryFontColor
      : AppColors.lightSecondaryFontColor;

  // Tertiary font color
  Color get tertiaryFontColor => isDark
      ? AppColors.darkTertiaryFontColor
      : AppColors.lightTertiaryFontColor;

  // Small Body
  TextStyle get smallBodyPrimaryTextStyle =>
      AppTypography.smallBodyTextStyle.copyWith(
        color: primaryFontColor,
      );

  TextStyle get smallBodySecondaryTextStyle =>
      AppTypography.smallBodyTextStyle.copyWith(
        color: secondaryFontColor,
      );

  TextStyle get smallBodyTertiaryTextStyle =>
      AppTypography.smallBodyTextStyle.copyWith(
        color: tertiaryFontColor,
      );

  // Medium Body
  TextStyle get mediumBodyPrimaryTextStyle =>
      AppTypography.mediumBodyTextStyle.copyWith(
        color: primaryFontColor,
      );

  TextStyle get mediumBodySecondaryTextStyle =>
      AppTypography.mediumBodyTextStyle.copyWith(
        color: secondaryFontColor,
      );

  TextStyle get mediumBodyTertiaryTextStyle =>
      AppTypography.mediumBodyTextStyle.copyWith(
        color: tertiaryFontColor,
      );

  // Large Body
  TextStyle get largeBodyPrimaryTextStyle =>
      AppTypography.largeBodyTextStyle.copyWith(
        color: primaryFontColor,
      );

  TextStyle get largeBodySecondaryTextStyle =>
      AppTypography.largeBodyTextStyle.copyWith(
        color: secondaryFontColor,
      );

  TextStyle get largeBodyTertiaryTextStyle =>
      AppTypography.largeBodyTextStyle.copyWith(
        color: tertiaryFontColor,
      );

  // Small Title
  TextStyle get smallTitlePrimaryTextStyle =>
      AppTypography.smallTitleTextStyle.copyWith(
        color: primaryFontColor,
      );

  TextStyle get smallTitleSecondaryTextStyle =>
      AppTypography.smallTitleTextStyle.copyWith(
        color: secondaryFontColor,
      );

  TextStyle get smallTitleTertiaryTextStyle =>
      AppTypography.smallTitleTextStyle.copyWith(
        color: tertiaryFontColor,
      );

  // Medium Title
  TextStyle get mediumTitlePrimaryTextStyle =>
      AppTypography.mediumTitleTextStyle.copyWith(
        color: primaryFontColor,
      );

  TextStyle get mediumTitleSecondaryTextStyle =>
      AppTypography.mediumTitleTextStyle.copyWith(
        color: secondaryFontColor,
      );

  TextStyle get mediumTitleTertiaryTextStyle =>
      AppTypography.mediumTitleTextStyle.copyWith(
        color: tertiaryFontColor,
      );

  // Large Title
  TextStyle get largeTitlePrimaryTextStyle =>
      AppTypography.largeTitleTextStyle.copyWith(
        color: primaryFontColor,
      );

  TextStyle get largeTitleSecondaryTextStyle =>
      AppTypography.largeTitleTextStyle.copyWith(
        color: secondaryFontColor,
      );

  TextStyle get largeTitleTertiaryTextStyle =>
      AppTypography.largeTitleTextStyle.copyWith(
        color: tertiaryFontColor,
      );

  // Caption
  TextStyle get captionPrimaryTextStyle =>
      AppTypography.captionTextStyle.copyWith(
        color: primaryFontColor,
      );

  TextStyle get captionSecondaryTextStyle =>
      AppTypography.captionTextStyle.copyWith(
        color: secondaryFontColor,
      );

  TextStyle get captionTertiaryTextStyle =>
      AppTypography.captionTextStyle.copyWith(
        color: tertiaryFontColor,
      );
}
