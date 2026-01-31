import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_constants.dart';

/// Editor action bar ortak layout: gradient buton + ikon + başlık (+ opsiyonel alt başlık).
/// Davranış ve stil editor'a özel değerlerle doldurulur.
class EditorActionBarBase extends StatelessWidget {
  const EditorActionBarBase({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.gradient,
    required this.shadowColor,
    required this.onTap,
    required this.enabled,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final LinearGradient gradient;
  final Color shadowColor;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppRadius.section),
            child: Ink(
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(AppRadius.section),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: Colors.white,
                      size: 22,
                    ),
                    const SizedBox(width: AppSpacing.iconBox),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.4,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: AppSpacing.subtextGap),
                          Text(
                            subtitle!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
