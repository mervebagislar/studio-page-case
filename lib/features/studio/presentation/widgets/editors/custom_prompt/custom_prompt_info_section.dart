import 'package:flutter/material.dart';

class CustomPromptInfoSection extends StatelessWidget {
  const CustomPromptInfoSection({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E1B4B).withValues(alpha: 0.3)
            : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : scheme.outline.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF3B82F6).withValues(alpha: 0.2),
                    const Color(0xFF6366F1).withValues(alpha: 0.15),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.tips_and_updates_rounded,
                size: 24,
                color: const Color(0xFF3B82F6),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Esnek Kullanım',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Görsel yükleyerek veya yüklemeden üretim yapabilirsiniz. Detaylı promptlar daha iyi sonuçlar verir.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
