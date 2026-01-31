import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';

class VisualEditorCards {
  static Widget buildOptionCard({
    required BuildContext context,
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    required OutputType outputType,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 110,
      decoration: BoxDecoration(
        gradient: isSelected ? VisualEditorUtils.getSelectedGradient(outputType) : null,
        color: isSelected ? null : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : isDark
              ? scheme.outlineVariant.withValues(alpha: 0.3)
              : scheme.outlineVariant,
          width: 1.5,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: VisualEditorUtils.getShadowColor(outputType).withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: isSelected ? Colors.white : scheme.onSurface,
                ),
                const SizedBox(height: 10),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isSelected ? Colors.white : scheme.onSurface,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    letterSpacing: 0.1,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildHorizontalOptionCard({
    required BuildContext context,
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    required OutputType outputType,
    double? height,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final cardHeight = height ?? 72;

    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
        gradient: isSelected ? VisualEditorUtils.getSelectedGradient(outputType) : null,
        color: isSelected ? null : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : isDark
              ? scheme.outlineVariant.withValues(alpha: 0.3)
              : scheme.outlineVariant,
          width: 1.5,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: VisualEditorUtils.getShadowColor(outputType).withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 24,
                color: isSelected ? Colors.white : scheme.onSurface,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  label,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: isSelected ? Colors.white : scheme.onSurface,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildMultiSelectCard({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required OutputType outputType,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        gradient: isSelected ? VisualEditorUtils.getSelectedGradient(outputType) : null,
        color: isSelected ? null : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : isDark
              ? scheme.outlineVariant.withValues(alpha: 0.3)
              : scheme.outlineVariant,
          width: 1.5,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: VisualEditorUtils.getShadowColor(outputType).withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(
                color: isSelected ? Colors.white : scheme.onSurface,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildBackgroundCard({
    required BuildContext context,
    required String label,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
    required OutputType outputType,
    String? colorCode,
    bool showLabel = true,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 72,
      decoration: BoxDecoration(
        gradient: isSelected ? VisualEditorUtils.getSelectedGradient(outputType) : null,
        color: isSelected ? null : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : isDark
              ? scheme.outlineVariant.withValues(alpha: 0.3)
              : scheme.outlineVariant,
          width: 1.5,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: VisualEditorUtils.getShadowColor(outputType).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: showLabel
                ? FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? Colors.white : scheme.outlineVariant,
                              width: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          label,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: isSelected ? Colors.white : scheme.onSurface,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        if (colorCode != null && colorCode.isNotEmpty) ...[
                          const SizedBox(height: 1),
                          Text(
                            colorCode,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: isSelected ? Colors.white70 : scheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                              fontSize: 8,
                              fontFamily: 'monospace',
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ],
                    ),
                  )
                : Center(
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.white : scheme.outlineVariant,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  static Widget buildAspectRatioCard({
    required BuildContext context,
    required String ratio,
    required String dimensions,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    required OutputType outputType,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 90,
      decoration: BoxDecoration(
        gradient: isSelected ? VisualEditorUtils.getSelectedGradient(outputType) : null,
        color: isSelected ? null : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : isDark
              ? scheme.outlineVariant.withValues(alpha: 0.3)
              : scheme.outlineVariant,
          width: 1.5,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: VisualEditorUtils.getShadowColor(outputType).withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: isSelected ? Colors.white : scheme.onSurface,
                ),
                const SizedBox(height: 4),
                Text(
                  ratio,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: isSelected ? Colors.white : scheme.onSurface,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 2),
                Text(
                  dimensions,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.8)
                        : scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    fontSize: 9,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildPhotoStyleCard({
    required BuildContext context,
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    required OutputType outputType,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 110,
      decoration: BoxDecoration(
        gradient: isSelected ? VisualEditorUtils.getSelectedGradient(outputType) : null,
        color: isSelected ? null : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : isDark
              ? scheme.outlineVariant.withValues(alpha: 0.3)
              : scheme.outlineVariant,
          width: 1.5,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: VisualEditorUtils.getShadowColor(outputType).withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: isSelected ? Colors.white : scheme.onSurface,
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: isSelected ? Colors.white : scheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
