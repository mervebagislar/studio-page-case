import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_constants.dart';

/// Editor section ortak layout: başlık satırı (ikon + title + subtitle) + child.
/// Gradient/renk ve spacing AppSpacing/AppRadius ile; variant card (default) veya simple.
enum EditorSectionVariant { card, simple }

class EditorSectionBase extends StatelessWidget {
  const EditorSectionBase({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.gradient,
    this.iconShadowColor,
    required this.child,
    this.padding,
    this.spacingBetweenHeaderAndChild,
    this.variant = EditorSectionVariant.card,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final LinearGradient? gradient;
  final Color? iconShadowColor;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? spacingBetweenHeaderAndChild;
  final EditorSectionVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final effectivePadding = padding ?? const EdgeInsets.all(AppSpacing.xl);
    final effectiveGradient = gradient ??
        LinearGradient(
          colors: [
            scheme.primary,
            scheme.primary.withValues(alpha: 0.8),
          ],
        );
    final effectiveShadowColor = iconShadowColor ?? scheme.shadow;
    final spacing = spacingBetweenHeaderAndChild ?? AppSpacing.xl;

    final headerChild = Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.iconBox),
          decoration: BoxDecoration(
            gradient: effectiveGradient,
            borderRadius: BorderRadius.circular(AppRadius.medium),
            boxShadow: [
              BoxShadow(
                color: effectiveShadowColor.withValues(alpha: 0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: AppSpacing.headerGap),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                  height: 1.2,
                ),
              ),
              if (subtitle != null && subtitle!.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        headerChild,
        SizedBox(height: spacing),
        child,
      ],
    );

    if (variant == EditorSectionVariant.simple) {
      return column;
    }

    return Container(
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.large),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: column,
    );
  }
}
