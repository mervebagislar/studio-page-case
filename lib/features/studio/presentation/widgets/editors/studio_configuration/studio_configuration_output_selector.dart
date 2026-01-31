import 'package:flutter/material.dart';
import 'package:studio_page_case/core/theme/app_theme.dart';

/// Studio configuration çıktı tipi seçici. Sadece UI.
class StudioConfigurationOutputSelector extends StatelessWidget {
  const StudioConfigurationOutputSelector({
    super.key,
    required this.selected,
  });

  final String selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildOption(
            context,
            'Website\nKatalog',
            Icons.language_rounded,
            selected == 'Website\nKatalog',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildOption(
            context,
            'Editorial\nStüdyo',
            Icons.photo_camera_outlined,
            false,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildOption(
            context,
            'Dış\nMekan',
            Icons.terrain_rounded,
            false,
          ),
        ),
      ],
    );
  }

  Widget _buildOption(
    BuildContext context,
    String label,
    IconData icon,
    bool isSelected,
  ) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 110,
      decoration: BoxDecoration(
        gradient: isSelected ? AppTheme.accentGradient : null,
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
                  color: const Color(0xFF00C6FF).withValues(alpha: 0.3),
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
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
