import 'package:flutter/material.dart';

class CustomPromptUtils {
  CustomPromptUtils._();

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF9333EA), Color(0xFFB75CFF)],
  );

  static const LinearGradient modernPurpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF9333EA), // Purple
      Color(0xFFC026D3), // Fuchsia
      Color(0xFFE879F9), // Pink
    ],
  );
}
