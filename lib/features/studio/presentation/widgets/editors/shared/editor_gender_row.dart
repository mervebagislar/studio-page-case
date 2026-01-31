import 'package:flutter/material.dart';

/// Kadın / Erkek seçim kartları. Instagram ve Görsel editörde ortak.
/// [trailingChild] verilirse üçüncü hücre olarak (örn. Manken özellikleri kartı) eklenir.
class EditorGenderRow extends StatelessWidget {
  const EditorGenderRow({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.selectedGender,
    required this.onGenderSelected,
    required this.gradient,
    required this.accent,
    this.trailingChild,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  final String? selectedGender;
  final ValueChanged<String> onGenderSelected;
  final LinearGradient gradient;
  final Color accent;
  final Widget? trailingChild;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      Expanded(
        child: _buildGenderCard(context, 'Kadın', Icons.person_rounded),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: _buildGenderCard(context, 'Erkek', Icons.person_rounded),
      ),
    ];
    if (trailingChild != null) {
      children.addAll([
        const SizedBox(width: 12),
        Expanded(child: trailingChild!),
      ]);
    }

    return Row(children: children);
  }

  Widget _buildGenderCard(BuildContext context, String gender, IconData icon) {
    final isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () => onGenderSelected(gender),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        height: 110,
        decoration: BoxDecoration(
          gradient: isSelected ? gradient : null,
          color: isSelected ? null : scheme.surfaceContainerHighest,
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
                    color: accent.withValues(alpha: 0.35),
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
              icon,
              size: 32,
              color: isSelected ? Colors.white : scheme.onSurfaceVariant,
            ),
            const SizedBox(height: 10),
            Text(
              gender,
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
