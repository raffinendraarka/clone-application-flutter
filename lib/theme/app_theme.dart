import 'dart:ui';
import 'package:flutter/material.dart';

/// Netflix Premium Cinematic Design System & Theme Configuration.
class AppTheme {
  AppTheme._();

  // Official Color Palette as specified in design requirements
  static const Color primaryBackground = Color(0xFF141414);
  static const Color secondaryBackground = Color(0xFF181818);
  static const Color netflixRed = Color(0xFFE50914);
  static const Color hoverRed = Color(0xFFF40612);
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFB3B3B3);
  static const Color cardBackground = Color(0xFF232323);
  static const Color borderColor = Color(0xFF333333);

  // Additional UI accent colors for badges and overlays
  static const Color matchGreen = Color(0xFF46D369);
  static const Color inputFill = Color(0xCC161616);
  static const Color modalOverlay = Color(0xCC000000);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primaryBackground,
      primaryColor: netflixRed,
      canvasColor: secondaryBackground,
      cardColor: cardBackground,
      dividerColor: borderColor,
      colorScheme: const ColorScheme.dark(
        primary: netflixRed,
        secondary: hoverRed,
        surface: secondaryBackground,
        onPrimary: primaryText,
        onSecondary: primaryText,
        onSurface: primaryText,
        outline: borderColor,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: primaryText,
          fontSize: 48,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.8,
          height: 1.1,
        ),
        displayMedium: TextStyle(
          color: primaryText,
          fontSize: 36,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          height: 1.15,
        ),
        headlineLarge: TextStyle(
          color: primaryText,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
        ),
        headlineMedium: TextStyle(
          color: primaryText,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1,
        ),
        titleLarge: TextStyle(
          color: primaryText,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: primaryText,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: primaryText,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.45,
        ),
        bodyMedium: TextStyle(
          color: secondaryText,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          color: primaryText,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: cardBackground,
        contentTextStyle: const TextStyle(
          color: primaryText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: borderColor),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: secondaryBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(borderColor.withValues(alpha: 0.8)),
        radius: const Radius.circular(4),
      ),
    );
  }
}

/// Enables smooth horizontal scrolling via mouse drag, trackpad, and touch on Web.
class NetflixScrollBehavior extends MaterialScrollBehavior {
  const NetflixScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}

