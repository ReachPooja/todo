import 'package:flutter/widgets.dart';

class Layout {
  Layout._();

  static const base = 8.0;

  //* Radius
  static const baseRadius = 12.0;
  static const smallRadius = 8.0;
  static const circularRadius = 100.0;

  //* Border Radius
  static const baseBorderRadius = BorderRadius.all(
    Radius.circular(baseRadius),
  );
  static const smallBorderRadius = BorderRadius.all(
    Radius.circular(smallRadius),
  );
  static const circularBorderRadius = BorderRadius.all(
    Radius.circular(circularRadius),
  );
}
