import 'package:flutter/material.dart';

/// Görsel editör animasyonlu arka plan gradient. Sadece UI; shadowColor view'dan geçilir.
class VisualEditorAnimatedBackground extends StatelessWidget {
  const VisualEditorAnimatedBackground({
    super.key,
    required this.scheme,
    required this.isDark,
    required this.shadowColor,
  });

  final ColorScheme scheme;
  final bool isDark;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.surface,
            shadowColor.withValues(alpha: isDark ? 0.04 : 0.02),
            scheme.surface,
            shadowColor.withValues(alpha: isDark ? 0.02 : 0.01),
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
      ),
    );
  }
}
