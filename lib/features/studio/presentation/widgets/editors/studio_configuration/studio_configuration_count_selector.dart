import 'package:flutter/material.dart';
import 'package:studio_page_case/core/theme/app_theme.dart';

/// Studio configuration görsel sayısı seçici. Sadece UI; count ve onSelect view'dan geçilir.
class StudioConfigurationCountSelector extends StatelessWidget {
  const StudioConfigurationCountSelector({
    super.key,
    required this.count,
    required this.onSelect,
  });

  final int count;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? scheme.outlineVariant.withValues(alpha: 0.3)
              : scheme.outlineVariant,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFB75CFF).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.image_outlined, size: 20, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  '$count Görsel',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (i) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: i == 0 ? 14 : 10,
                  height: i == 0 ? 14 : 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: i == 0 ? AppTheme.primaryGradient : null,
                    color: i == 0
                        ? null
                        : scheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
