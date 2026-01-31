import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_chip.dart';

class InstagramEditorAngleSection extends StatelessWidget {
  const InstagramEditorAngleSection({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.selectedShootingAngle,
    required this.onShootingAngleSelected,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  final String? selectedShootingAngle;
  final ValueChanged<String> onShootingAngleSelected;

  static const List<String> _options = [
    'Low Angle',
    'Selfie',
    'Medium Shot',
    'Full-body',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _options.map((option) {
        final isSelected = selectedShootingAngle == option;
        return InstagramEditorChip(
          label: option,
          isSelected: isSelected,
          onTap: () => onShootingAngleSelected(option),
          theme: theme,
          scheme: scheme,
          isDark: isDark,
        );
      }).toList(),
    );
  }
}
