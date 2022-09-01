import 'package:flutter/material.dart';

class AppColors {
  static const primaryBackgroundColor = Color.fromARGB(255, 255, 226, 230);
  static const primaryColor = Color(0xff9d8189);
  static const accentColor = Color(0xfff4acb7);

  //* Text
  static const lightPrimaryFontColor = Colors.black;
  static const lightSecondaryFontColor = Colors.grey;
  static final lightTertiaryFontColor = Colors.grey.shade400;

  static const darkPrimaryFontColor = Colors.white;
  static const darkSecondaryFontColor = Colors.grey;
  static final darkTertiaryFontColor = Colors.grey.shade600;

  static MaterialColor get primarySwatch {
    const color = <int, Color>{
      50: Color(0xffe3dbdd),
      100: Color(0xffd1c3c7),
      200: Color(0xffbeabb1),
      300: Color(0xffab939a),
      400: Color(0xff997b84),
      500: Color(0xff9d8189),
      600: Color(0xff83666f),
      700: Color(0xff6c545b),
      800: Color(0xff544146),
      900: Color(0xff3c2e32),
    };
    return const MaterialColor(0xff9d8189, color);
  }
}
