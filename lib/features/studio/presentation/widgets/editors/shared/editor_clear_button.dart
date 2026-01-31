import 'package:flutter/material.dart';

/// "Seçimi temizle" butonu. Arka plan, obje modu vb. bölümlerde ortak kullanılır.
class EditorClearButton extends StatelessWidget {
  const EditorClearButton({
    super.key,
    required this.theme,
    required this.scheme,
    required this.onTap,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              scheme.errorContainer.withValues(alpha: 0.4),
              scheme.errorContainer.withValues(alpha: 0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: scheme.error.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.clear_rounded, size: 20, color: scheme.error),
            const SizedBox(width: 10),
            Text(
              'Seçimi temizle',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.error,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
