
import 'package:flutter/material.dart';
import 'package:mobilestore/theme/theme_data.dart';

final lightTheme = ThemeData(
    primaryColor: lightColorScheme.primary,
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: lightColorScheme.primary,
        onPrimary: lightColorScheme.onPrimary,
        inversePrimary: lightColorScheme.inversePrimary,
        secondary: lightColorScheme.secondary,
        onSecondary: lightColorScheme.onSecondary,
        error: lightColorScheme.error,
        onError: lightColorScheme.onError,
        surface: lightColorScheme.surface,
        onSurface: lightColorScheme.onSurface,
        surfaceTint: lightColorScheme.surfaceTint,
        outline: lightColorScheme.outline,
        outlineVariant: lightColorScheme.outlineVariant
    )
);

ThemeData getLightTheme() {
  return lightTheme;
}