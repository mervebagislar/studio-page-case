import 'package:flutter/material.dart';

/// Video editörü ortak sabitler. Sadece UI/stil; state yok.
class VideoEditorUtils {
  VideoEditorUtils._();

  /// Modern gradient for video editor (Indigo → Purple → Pink)
  static const LinearGradient modernGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6366F1), // Indigo
      Color(0xFF8B5CF6), // Purple
      Color(0xFFEC4899), // Pink
    ],
  );

  static const Color accentColor = Color(0xFF6366F1);
  static const Color shadowColor = Color(0xFF6366F1);
}
