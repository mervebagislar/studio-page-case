import 'package:flutter/material.dart';
import 'package:studio_page_case/core/theme/app_theme.dart';

enum OutputType { websiteKatalog, editorialStudio, disMekan }

class VisualEditorUtils {
  static Color getShadowColor(OutputType outputType) {
    switch (outputType) {
      case OutputType.websiteKatalog:
        return const Color(0xFF00C6FF);
      case OutputType.editorialStudio:
        return const Color(0xFF9333EA);
      case OutputType.disMekan:
        return const Color(0xFFFF5C9D);
    }
  }

  static LinearGradient getSelectedGradient(OutputType outputType) {
    switch (outputType) {
      case OutputType.websiteKatalog:
        return AppTheme.accentGradient;
      case OutputType.editorialStudio:
        return const LinearGradient(
          colors: [Color(0xFF9333EA), Color(0xFFB75CFF)],
        );
      case OutputType.disMekan:
        return const LinearGradient(
          colors: [Color(0xFFFF5C9D), Color(0xFFFF8A65)],
        );
    }
  }

  static String getPreviewImagePath(OutputType selectedOutput, String? selectedModel) {
    switch (selectedOutput) {
      case OutputType.websiteKatalog:
        return selectedModel == 'Mankensiz'
            ? 'assets/website-mankensiz.png'
            : 'assets/website-mankenli.png';
      case OutputType.editorialStudio:
        return selectedModel == 'Mankensiz'
            ? 'assets/stillife-mankensiz.png'
            : 'assets/stillife-mankenli.jpg';
      case OutputType.disMekan:
        return selectedModel == 'Mankensiz'
            ? 'assets/outdoor-mankensiz.png'
            : 'assets/outdoor-mankenli.jpg';
    }
  }
}
