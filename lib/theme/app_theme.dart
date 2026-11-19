import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xFF087EA4);
  static const primaryDark = Color(0xFF8DD8F0);
  static const primaryContainer = Color(0xFFB9EAF8);
  static const primaryContainerDark = Color(0xFF00526D);
  static const onPrimaryContainer = Color(0xFF001F29);

  static const backgroundLight = Color(0xFFF8FAFB);
  static const backgroundDark = Color(0xFF101416);
  static const surfaceVariantLight = Color(0xFFDCE5E8);
  static const surfaceVariantDark = Color(0xFF3F484C);
  static const onBackgroundLight = Color(0xFF171D1F);
  static const onBackgroundDark = Color(0xFFE0E3E5);
  static const onSurfaceVariantLight = Color(0xFF3F484C);
  static const onSurfaceVariantDark = Color(0xFFBEC8CC);

  static const secondaryLight = Color(0xFF4C6269);
  static const secondaryDark = Color(0xFFB1CBD3);
  static const secondaryContainerLight = Color(0xFFCFE6ED);
  static const secondaryContainerDark = Color(0xFF344A51);

  static const tertiaryLight = Color(0xFF655F00);
  static const tertiaryDark = Color(0xFFD6CB62);
  static const error = Color(0xFFBA1A1A);
}

abstract final class AppTheme {
  static final ThemeData light = _build(_lightScheme, Brightness.light);
  static final ThemeData dark = _build(_darkScheme, Brightness.dark);

  static const TextTheme _textTheme = TextTheme(
    headlineSmall: TextStyle(
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      height: 16 / 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  );

  static final ColorScheme _lightScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryLight,
    onSecondary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.backgroundLight,
    onSurface: AppColors.onBackgroundLight,
  ).copyWith(
    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: AppColors.onPrimaryContainer,
    secondaryContainer: AppColors.secondaryContainerLight,
    onSecondaryContainer: AppColors.onBackgroundLight,
    tertiary: AppColors.tertiaryLight,
    onTertiary: Colors.white,
    surfaceContainerHighest: AppColors.surfaceVariantLight,
    onSurfaceVariant: AppColors.onSurfaceVariantLight,
  );

  static final ColorScheme _darkScheme = ColorScheme.dark(
    primary: AppColors.primaryDark,
    onPrimary: AppColors.backgroundDark,
    secondary: AppColors.secondaryDark,
    onSecondary: AppColors.backgroundDark,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.backgroundDark,
    onSurface: AppColors.onBackgroundDark,
  ).copyWith(
    primaryContainer: AppColors.primaryContainerDark,
    onPrimaryContainer: AppColors.primaryContainer,
    secondaryContainer: AppColors.secondaryContainerDark,
    onSecondaryContainer: AppColors.primaryContainer,
    tertiary: AppColors.tertiaryDark,
    onTertiary: AppColors.backgroundDark,
    surfaceContainerHighest: AppColors.surfaceVariantDark,
    onSurfaceVariant: AppColors.onSurfaceVariantDark,
  );

  static ThemeData _build(ColorScheme scheme, Brightness brightness) {
    return ThemeData(
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: _textTheme,
      appBarTheme: AppBarThemeData(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        elevation: 0,
      ),
    );
  }
}
