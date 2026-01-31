import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/video_editor/video_editor_utils.dart';

/// Video editörü "Video Oluştur" butonu. Sadece UI; onGenerate view'dan geçilir.
class VideoEditorGenerateButton extends StatelessWidget {
  const VideoEditorGenerateButton({
    super.key,
    required this.isEnabled,
    required this.credits,
    required this.onGenerate,
    required this.theme,
    required this.scheme,
  });

  final bool isEnabled;
  final int credits;
  final VoidCallback? onGenerate;
  final ThemeData theme;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          gradient: isEnabled ? VideoEditorUtils.modernGradient : null,
          color: isEnabled ? null : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: VideoEditorUtils.shadowColor.withValues(alpha: 0.4),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
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
            onTap: isEnabled ? onGenerate : null,
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
                      Icons.play_circle_filled_rounded,
                      color: isEnabled
                          ? Colors.white
                          : scheme.onSurfaceVariant.withValues(alpha: 0.5),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Video Oluştur',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: isEnabled
                          ? Colors.white
                          : scheme.onSurfaceVariant.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isEnabled
                          ? Colors.white.withValues(alpha: 0.2)
                          : scheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
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
                          size: 16,
                          color: isEnabled
                              ? Colors.white
                              : scheme.onSurfaceVariant.withValues(alpha: 0.5),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$credits kredi',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: isEnabled
                                ? Colors.white
                                : scheme.onSurfaceVariant.withValues(
                                    alpha: 0.5,
                                  ),
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
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
