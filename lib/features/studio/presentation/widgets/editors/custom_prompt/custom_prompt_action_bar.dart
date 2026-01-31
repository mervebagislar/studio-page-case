import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/custom_prompt/custom_prompt_utils.dart';

class CustomPromptActionBar extends StatelessWidget {
  const CustomPromptActionBar({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.isEnabled,
    this.onGenerateTap,
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
        decoration: BoxDecoration(
          gradient: isEnabled ? CustomPromptUtils.modernPurpleGradient : null,
          color: isEnabled ? null : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: const Color(0xFF9333EA).withValues(alpha: 0.4),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: const Color(0xFFC026D3).withValues(alpha: 0.3),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  Text(
                    'Görsel Oluştur',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: isEnabled
                          ? Colors.white
                          : scheme.onSurfaceVariant.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isEnabled
                              ? Colors.white.withValues(alpha: 0.2)
                              : scheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isEnabled
                                ? Colors.white.withValues(alpha: 0.3)
                                : Colors.transparent,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.auto_awesome_rounded,
                              size: 14,
                              color: isEnabled
                                  ? Colors.white
                                  : scheme.onSurfaceVariant.withValues(alpha: 0.5),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '8',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: isEnabled
                                    ? Colors.white
                                    : scheme.onSurfaceVariant.withValues(alpha: 0.5),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isEnabled
                              ? Colors.white.withValues(alpha: 0.2)
                              : scheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isEnabled
                                ? Colors.white.withValues(alpha: 0.3)
                                : Colors.transparent,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.collections_rounded,
                              size: 14,
                              color: isEnabled
                                  ? Colors.white
                                  : scheme.onSurfaceVariant.withValues(alpha: 0.5),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '4',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: isEnabled
                                    ? Colors.white
                                    : scheme.onSurfaceVariant.withValues(alpha: 0.5),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
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
