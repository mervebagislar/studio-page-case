import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/background_editor/background_editor_utils.dart';


class BackgroundEditorActionBar extends StatelessWidget {
  const BackgroundEditorActionBar({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.isEnabled,
    required this.onGenerateTap,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  final bool isEnabled;
  final VoidCallback? onGenerateTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          gradient: isEnabled ? BackgroundEditorUtils.modernCyanGradient : null,
          color: isEnabled ? null : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: const Color(0xFF06B6D4).withValues(alpha: 0.4),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: const Color(0xFF14B8A6).withValues(alpha: 0.3),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: isEnabled ? onGenerateTap : null,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isEnabled
                          ? Colors.white.withValues(alpha: 0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      size: 24,
                      color: isEnabled
                          ? Colors.white
                          : scheme.onSurfaceVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Arka Planı Değiştir',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: isEnabled
                              ? Colors.white
                              : scheme.onSurfaceVariant.withValues(alpha: 0.5),
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '40 Kredi  ·  1 Görsel',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isEnabled
                              ? Colors.white.withValues(alpha: 0.9)
                              : scheme.onSurfaceVariant.withValues(alpha: 0.5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
