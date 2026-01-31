import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/manken_modal_data.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_manken_modal.dart';

/// Manken Özellikleri kartı. Visual ve Instagram editörlerinde ortak; tıklanınca [EditorMankenModal] açar.
class EditorMankenCard extends StatelessWidget {
  const EditorMankenCard({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.initialData,
    required this.gradient,
    required this.accent,
    required this.onSave,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  final MankenModalData initialData;
  final LinearGradient gradient;
  final Color accent;
  final ValueChanged<MankenModalData> onSave;

  @override
  Widget build(BuildContext context) {
    final isSaved = initialData.bodyType != null;

    return GestureDetector(
      onTap: () {
        EditorMankenModal.show(
          context,
          initial: initialData,
          gradient: gradient,
          accent: accent,
          onSave: onSave,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        height: 110,
        decoration: BoxDecoration(
          gradient: isSaved ? gradient : null,
          color: isSaved ? null : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          border: isSaved
              ? Border.all(color: Colors.white.withValues(alpha: 0.2), width: 2)
              : Border.all(
                  color: isDark
                      ? scheme.outline.withValues(alpha: 0.2)
                      : scheme.outline.withValues(alpha: 0.15),
                  width: 1.5,
                ),
          boxShadow: isSaved
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isSaved)
                    const Icon(
                        Icons.check_rounded, size: 20, color: Colors.white),
                  if (isSaved) const SizedBox(height: 4),
                  Icon(
                    Icons.manage_accounts_rounded,
                    size: 28,
                    color: isSaved ? Colors.white : scheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manken Özellikleri',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: isSaved ? Colors.white : scheme.onSurface,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Positioned(
              top: -4,
              right: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Yeni',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
