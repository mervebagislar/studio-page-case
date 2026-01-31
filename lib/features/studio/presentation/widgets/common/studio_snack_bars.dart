import 'package:flutter/material.dart';
import 'package:studio_page_case/core/theme/app_theme.dart';


class StudioSnackBars {
  StudioSnackBars._();

  static const Duration _defaultDuration = Duration(seconds: 2);

  static void showSuccess(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.primaryGradient.colors.first,
        behavior: SnackBarBehavior.floating,
        duration: duration ?? _defaultDuration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: duration ?? _defaultDuration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
