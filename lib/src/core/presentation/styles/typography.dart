import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  //* Family
  static const fontFamily = 'Ubuntu';

  //* Body font sizes
  static const smallBodyFontSize = 14.0;
  static const mediumBodyFontSize = 46.0;
  static const largeBodyFontSize = 18.0;

  //* Title font sizes
  static const smallTitleFontSize = 18.0;
  static const mediumTitleFontSize = 20.0;
  static const largeTitleFontSize = 22.0;

  //* Caption font size
  static const captionFontSize = 12.0;

  //* Body text styles
  static const smallBodyTextStyle = TextStyle(
    fontSize: smallBodyFontSize,
  );

  static const mediumBodyTextStyle = TextStyle(
    fontSize: mediumBodyFontSize,
  );

  static const largeBodyTextStyle = TextStyle(
    fontSize: largeBodyFontSize,
  );

  //* Title text styles
  static const smallTitleTextStyle = TextStyle(
    fontSize: smallTitleFontSize,
    fontWeight: FontWeight.w500,
  );

  static const mediumTitleTextStyle = TextStyle(
    fontSize: mediumTitleFontSize,
    fontWeight: FontWeight.w600,
  );

  static const largeTitleTextStyle = TextStyle(
    fontSize: largeTitleFontSize,
    fontWeight: FontWeight.w700,
  );

  //* Caption text style
  static const captionTextStyle = TextStyle(
    fontSize: captionFontSize,
  );
}
