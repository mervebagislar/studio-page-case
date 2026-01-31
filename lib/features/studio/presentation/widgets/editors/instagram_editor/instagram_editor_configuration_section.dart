import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_aspect_ratio_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart' show OutputType;

class InstagramEditorConfigurationSection extends StatelessWidget {
  final String? selectedAspectRatio;
  final ValueChanged<String?> onAspectRatioSelected;
  final int? selectedImageCount;
  final ValueChanged<int?> onImageCountSelected;

  static const LinearGradient _instagramGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF6366F1), Color(0xFFD946EF), Color(0xFFF97316)],
  );
  static const Color _instagramAccent = Color(0xFF6366F1);

  final bool showAspectRatioSelector;
  final bool showImageCountSelector;

  const InstagramEditorConfigurationSection({
    super.key,
    required this.selectedAspectRatio,
    required this.onAspectRatioSelected,
    required this.selectedImageCount,
    required this.onImageCountSelected,
    this.showAspectRatioSelector = true,
    this.showImageCountSelector = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final children = <Widget>[];
    if (showAspectRatioSelector) {
      children.add(_buildAspectRatioSelector(context, theme, scheme, isDark));
      if (showImageCountSelector) children.add(const SizedBox(height: 12));
    }
    if (showImageCountSelector) {
      children.add(_buildImageCountSelector(context, theme, scheme, isDark));
    }
    if (children.isEmpty) return const SizedBox.shrink();
    if (children.length == 1) return children.single;

    return Column(
      children: children,
    );
  }

  Widget _buildAspectRatioSelector(
    BuildContext context,
    ThemeData theme,
    ColorScheme scheme,
    bool isDark,
  ) {
    return EditorAspectRatioSection(
      selectedAspectRatio: selectedAspectRatio,
      onAspectRatioSelected: onAspectRatioSelected,
      outputType: OutputType.disMekan,
    );
  }

  Widget _buildImageCountSelector(
    BuildContext context,
    ThemeData theme,
    ColorScheme scheme,
    bool isDark,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildCountCard(
            context: context,
            count: 1,
            theme: theme,
            scheme: scheme,
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildCountCard(
            context: context,
            count: 4,
            theme: theme,
            scheme: scheme,
            isDark: isDark,
          ),
        ),
      ],
    );
  }

  Widget _buildCountCard({
    required BuildContext context,
    required int count,
    required ThemeData theme,
    required ColorScheme scheme,
    required bool isDark,
  }) {
    final isSelected = selectedImageCount == count;

    return GestureDetector(
      onTap: () => onImageCountSelected(count),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        height: 110,
        decoration: BoxDecoration(
          gradient: isSelected
              ? _instagramGradient
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    scheme.surfaceContainerHighest,
                    scheme.surfaceContainerHigh,
                  ],
                ),
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: Colors.white.withValues(alpha: 0.2), width: 2)
              : Border.all(
                  color: isDark
                      ? scheme.outline.withValues(alpha: 0.2)
                      : scheme.outline.withValues(alpha: 0.15),
                  width: 1.5,
                ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: _instagramAccent.withValues(alpha: 0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_rounded,
              size: 32,
              color: isSelected ? Colors.white : scheme.onSurfaceVariant,
            ),
            const SizedBox(height: 10),
            Text(
              '$count Görsel',
              style: theme.textTheme.titleMedium?.copyWith(
                color: isSelected ? Colors.white : scheme.onSurface,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
