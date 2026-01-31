import 'package:flutter/material.dart';

class AppTheme {
  static const _primaryPurple = Color(0xFFB75CFF);
  static const _primaryPink = Color(0xFFFF5C9D);
  static const _accentBlue = Color(0xFF00C6FF);
  static const _accentCyan = Color(0xFF00E5FF);

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      colorScheme: const ColorScheme.light(
        primary: _primaryPurple,
        primaryContainer: Color(0xFFF3E5FF),
        secondary: _primaryPink,
        secondaryContainer: Color(0xFFFFE5F0),
        surface: Color(0xFFFFFFFF),
        surfaceContainerHighest: Color(0xFFF1F3F5),
        onPrimary: Colors.white,
        onPrimaryContainer: Color(0xFF4A0072),
        onSecondary: Colors.white,
        onSurface: Color(0xFF1A1C1E),
        onSurfaceVariant: Color(0xFF5F6368),
        outline: Color(0xFFDDE1E6),
        outlineVariant: Color(0xFFE8EAED),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Color(0xFFF8F9FA),
        foregroundColor: Color(0xFF1A1C1E),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0A0E1A),
      colorScheme: const ColorScheme.dark(
        primary: _primaryPurple,
        primaryContainer: Color(0xFF2D1B3D),
        secondary: _primaryPink,
        secondaryContainer: Color(0xFF3D1F2D),
        surface: Color(0xFF151B2D),
        surfaceContainerHighest: Color(0xFF1E2638),
        onPrimary: Colors.white,
        onPrimaryContainer: Color(0xFFE5B3FF),
        onSecondary: Colors.white,
        onSurface: Color(0xFFE8EAED),
        onSurfaceVariant: Color(0xFFADB5BD),
        outline: Color(0xFF2D3748),
        outlineVariant: Color(0xFF1E2638),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: const Color(0xFF151B2D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Color(0xFF0A0E1A),
        foregroundColor: Color(0xFFE8EAED),
      ),
    );
  }

  static LinearGradient primaryGradient = const LinearGradient(
    colors: [_primaryPurple, _primaryPink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient accentGradient = const LinearGradient(
    colors: [_accentBlue, _accentCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}