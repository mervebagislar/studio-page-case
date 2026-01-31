import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_clear_button.dart';

/// Renk → hex string (arka plan kartı için).
String _colorToHex(Color color) {
  return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
}

/// Arka plan seçici (Gri / Beyaz / Kendin Belirle + mod + açıklama). Görsel editörde ortak.
class EditorBackgroundSection extends StatelessWidget {
  const EditorBackgroundSection({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.selectedBackground,
    required this.customBackgroundColor,
    required this.kendinBelirleBackgroundMode,
    required this.backgroundDescriptionController,
    required this.onBackgroundClear,
    required this.onBackgroundSelected,
    required this.onKendinBelirleModeKendinBelirle,
    required this.onKendinBelirleModeTRYPIX,
    required this.onBackgroundDescriptionChanged,
    required this.gradient,
    required this.accent,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  final String? selectedBackground;
  final Color? customBackgroundColor;
  final String? kendinBelirleBackgroundMode;
  final TextEditingController backgroundDescriptionController;
  final VoidCallback onBackgroundClear;
  final ValueChanged<String?> onBackgroundSelected;
  final VoidCallback onKendinBelirleModeKendinBelirle;
  final VoidCallback onKendinBelirleModeTRYPIX;
  final VoidCallback onBackgroundDescriptionChanged;
  final LinearGradient gradient;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final hasSelection = selectedBackground != null ||
        customBackgroundColor != null ||
        backgroundDescriptionController.text.isNotEmpty;
    final showKendinBelirleOptions = selectedBackground == 'Kendin Belirle' ||
        customBackgroundColor != null ||
        backgroundDescriptionController.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasSelection) ...[
          EditorClearButton(
            theme: theme,
            scheme: scheme,
            onTap: onBackgroundClear,
          ),
          const SizedBox(height: 14),
        ],
        Row(
          children: [
            Expanded(
              child: _buildBackgroundCard(
                context,
                label: 'Gri',
                color: Colors.grey,
                isSelected: selectedBackground == 'Gri' && customBackgroundColor == null,
                onTap: () => onBackgroundSelected('Gri'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBackgroundCard(
                context,
                label: 'Beyaz',
                color: Colors.white,
                isSelected: selectedBackground == 'Beyaz' && customBackgroundColor == null,
                onTap: () => onBackgroundSelected('Beyaz'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBackgroundCard(
                context,
                label: 'Kendin Belirle',
                color: customBackgroundColor ?? Colors.purple,
                isSelected: showKendinBelirleOptions,
                onTap: () => onBackgroundSelected('Kendin Belirle'),
                colorCode: customBackgroundColor != null
                    ? _colorToHex(customBackgroundColor!)
                    : backgroundDescriptionController.text.isNotEmpty
                        ? backgroundDescriptionController.text
                        : null,
                showLabel: customBackgroundColor == null &&
                    backgroundDescriptionController.text.isEmpty,
              ),
            ),
          ],
        ),
        if (showKendinBelirleOptions) ...[
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildModeCard(
                  context,
                  label: 'Kendin Belirle',
                  isSelected: kendinBelirleBackgroundMode == 'Kendin Belirle',
                  onTap: onKendinBelirleModeKendinBelirle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildModeCard(
                  context,
                  label: 'TRYPIX Belirlesin',
                  isSelected: kendinBelirleBackgroundMode == 'TRYPIX Belirlesin',
                  onTap: onKendinBelirleModeTRYPIX,
                ),
              ),
            ],
          ),
          if (kendinBelirleBackgroundMode == 'Kendin Belirle') ...[
            const SizedBox(height: 14),
            TextField(
              controller: backgroundDescriptionController,
              onChanged: (_) => onBackgroundDescriptionChanged(),
              maxLines: 1,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: 'Renk / açıklama (örn: light gray, #E5E7EB)',
                hintStyle: TextStyle(
                  color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
                filled: true,
                fillColor: scheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: isDark
                        ? scheme.outlineVariant.withValues(alpha: 0.3)
                        : scheme.outlineVariant,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ],
        ],
      ],
    );
  }

  Widget _buildBackgroundCard(
    BuildContext context, {
    required String label,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
    String? colorCode,
    bool showLabel = true,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            gradient: isSelected ? gradient : null,
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
                      color: accent.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
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
                              color: isSelected
                                  ? Colors.white
                                  : scheme.outlineVariant,
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
                              color: isSelected
                                  ? Colors.white70
                                  : scheme.onSurfaceVariant,
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
                          color: isSelected
                              ? Colors.white
                              : scheme.outlineVariant,
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

  Widget _buildModeCard(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            gradient: isSelected ? gradient : null,
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
                      color: accent.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
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
}
