import 'package:flutter/material.dart';

class BackgroundEditorUtils {
  BackgroundEditorUtils._();

  static String colorToHex(Color c) {
    return '#${(c.r * 255).round().toRadixString(16).padLeft(2, '0')}${(c.g * 255).round().toRadixString(16).padLeft(2, '0')}${(c.b * 255).round().toRadixString(16).padLeft(2, '0')}'.toUpperCase();
  }

  static Color? hexToColor(String s) {
    s = s.trim().replaceFirst('#', '');
    if (s.length == 6) {
      final n = int.tryParse(s, radix: 16);
      if (n != null) return Color(0xFF000000 | n);
    }
    return null;
  }

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFFFF5C9D), Color(0xFFFF8A65)],
  );

  /// Modern cyan/teal gradient for background editor
  static const LinearGradient modernCyanGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF06B6D4), // Cyan
      Color(0xFF14B8A6), // Teal
      Color(0xFF10B981), // Emerald
    ],
  );
}
