import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_utils.dart';

class InstagramEditorChip extends StatelessWidget {
  const InstagramEditorChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.theme,
    required this.scheme,
    required this.isDark,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        gradient: isSelected
            ? InstagramEditorUtils.instagramGradient
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  scheme.surfaceContainerHighest,
                  scheme.surfaceContainerHigh,
                ],
              ),
        borderRadius: BorderRadius.circular(16),
        border: isSelected
            ? Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.5)
            : Border.all(
                color: isDark
                    ? scheme.outline.withValues(alpha: 0.2)
                    : scheme.outline.withValues(alpha: 0.15),
                width: 1.5,
              ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: InstagramEditorUtils.instagramAccent.withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(
                color: isSelected ? Colors.white : scheme.onSurface,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
