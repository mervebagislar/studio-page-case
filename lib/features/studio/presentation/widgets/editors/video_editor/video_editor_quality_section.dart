import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/video_editor/video_editor_utils.dart';

/// Video editörü kalite seçici: iki kalite kartı. Sadece UI; seçim view'dan callback ile gelir.
class VideoEditorQualitySection extends StatelessWidget {
  const VideoEditorQualitySection({
    super.key,
    required this.selectedQuality,
    required this.onQualitySelected,
    required this.theme,
    required this.scheme,
    required this.isDark,
  });

  final String selectedQuality;
  final ValueChanged<String> onQualitySelected;
  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: VideoEditorQualityCard(
            quality: 'Basic Video',
            icon: Icons.videocam_rounded,
            credits: 120,
            description: '720p • 5 saniye',
            isSelected: selectedQuality == 'Basic Video',
            onTap: () => onQualitySelected('Basic Video'),
            theme: theme,
            scheme: scheme,
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: VideoEditorQualityCard(
            quality: 'Pro Video',
            icon: Icons.high_quality_rounded,
            credits: 200,
            description: '1080p • 10 saniye',
            isSelected: selectedQuality == 'Pro Video',
            onTap: () => onQualitySelected('Pro Video'),
            theme: theme,
            scheme: scheme,
            isDark: isDark,
          ),
        ),
      ],
    );
  }
}

/// Tek kalite kartı. Sadece UI.
class VideoEditorQualityCard extends StatelessWidget {
  const VideoEditorQualityCard({
    super.key,
    required this.quality,
    required this.icon,
    required this.credits,
    required this.description,
    required this.isSelected,
    required this.onTap,
    required this.theme,
    required this.scheme,
    required this.isDark,
  });

  final String quality;
  final IconData icon;
  final int credits;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;
  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: isSelected ? VideoEditorUtils.modernGradient : null,
            color: isSelected
                ? null
                : isDark
                    ? const Color(0xFF1E293B).withValues(alpha: 0.5)
                    : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : scheme.outline.withValues(alpha: 0.2),
              width: 2,
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: VideoEditorUtils.shadowColor.withValues(alpha: 0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              if (!isSelected)
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.2)
                      : VideoEditorUtils.accentColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.3)
                        : VideoEditorUtils.accentColor.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: isSelected ? Colors.white : VideoEditorUtils.accentColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                quality,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: isSelected ? Colors.white : scheme.onSurface,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.85)
                      : scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.2)
                      : VideoEditorUtils.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.3)
                        : VideoEditorUtils.accentColor.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      size: 14,
                      color: isSelected
                          ? Colors.white
                          : VideoEditorUtils.accentColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$credits kredi',
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : VideoEditorUtils.accentColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
