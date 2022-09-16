import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void themeModeChanged(ThemeMode mode) {
    emit(mode);
  }

  @override
  ThemeMode fromJson(Map<String, dynamic> json) =>
      stringToThemeMode(json['theme'] as String);

  @override
  Map<String, String> toJson(ThemeMode state) =>
      {'theme': themeModeToString(state)};
}

String themeModeToString(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return 'light';
    case ThemeMode.dark:
      return 'dark';
    case ThemeMode.system:
      return 'system';
  }
}

ThemeMode stringToThemeMode(String mode) {
  switch (mode) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}
