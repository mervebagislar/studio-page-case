import 'package:flutter/material.dart';

/// Mankenli / Mankensiz seçim kartları. Görsel editör ve Studio konfigürasyonunda ortak.
class EditorModelTypeRow extends StatelessWidget {
  const EditorModelTypeRow({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.selectedModel,
    required this.onModelSelected,
    required this.gradient,
    required this.accent,
    this.height = 72,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  final String? selectedModel;
  final ValueChanged<String?> onModelSelected;
  final LinearGradient gradient;
  final Color accent;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildCard(context, 'Mankenli', Icons.person_outline),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildCard(context, 'Mankensiz', Icons.person_off_outlined),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, String label, IconData icon) {
    final isSelected = selectedModel == label;

    return GestureDetector(
      onTap: () => onModelSelected(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        height: height,
        decoration: BoxDecoration(
          gradient: isSelected ? gradient : null,
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
                    color: accent.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
