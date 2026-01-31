import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/background_editor/background_editor_utils.dart';

class BackgroundEditorPoseSection extends StatelessWidget {
  const BackgroundEditorPoseSection({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.poseCorrectionEnabled,
    required this.onChanged,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  final bool poseCorrectionEnabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: poseCorrectionEnabled
              ? LinearGradient(
                  colors: [
                    const Color(0xFF06B6D4).withValues(alpha: 0.15),
                    const Color(0xFF14B8A6).withValues(alpha: 0.1),
                  ],
                )
              : null,
          color: poseCorrectionEnabled
              ? null
              : isDark
                  ? const Color(0xFF0F2830).withValues(alpha: 0.5)
                  : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: poseCorrectionEnabled
                ? const Color(0xFF06B6D4).withValues(alpha: 0.3)
                : isDark
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => onChanged(!poseCorrectionEnabled),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: poseCorrectionEnabled
                          ? BackgroundEditorUtils.modernCyanGradient
                          : LinearGradient(
                              colors: [
                                const Color(0xFF06B6D4).withValues(alpha: 0.15),
                                const Color(0xFF14B8A6).withValues(alpha: 0.1),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: poseCorrectionEnabled
                          ? [
                              BoxShadow(
                                color: const Color(0xFF06B6D4).withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      Icons.auto_fix_high_rounded,
                      size: 24,
                      color: poseCorrectionEnabled
                          ? Colors.white
                          : const Color(0xFF06B6D4),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Model Pozunu Düzelt',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Profesyonel duruşa dönüştürür',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                            height: 1.5,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 56,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: poseCorrectionEnabled
                          ? BackgroundEditorUtils.modernCyanGradient
                          : null,
                      color: poseCorrectionEnabled
                          ? null
                          : scheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: poseCorrectionEnabled
                          ? [
                              BoxShadow(
                                color: const Color(0xFF06B6D4).withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          left: poseCorrectionEnabled ? 26 : 2,
                          top: 2,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
