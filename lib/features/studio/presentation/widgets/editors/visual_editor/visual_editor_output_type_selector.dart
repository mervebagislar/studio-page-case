import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_cards.dart';

/// Output type seçimi UI'ı (Website Katalog, Editorial Stüdyo, Dış Mekan).
/// Sadece UI + callback; state parent'ta kalır.
class VisualEditorOutputTypeSelector extends StatelessWidget {
  final OutputType selectedType;
  final ValueChanged<OutputType> onTypeSelected;

  const VisualEditorOutputTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildAnimatedSelectionCard(
            delay: 0,
            child: VisualEditorCards.buildOptionCard(
              context: context,
              label: 'Website\nKatalog',
              icon: Icons.language_rounded,
              isSelected: selectedType == OutputType.websiteKatalog,
              onTap: () => onTypeSelected(OutputType.websiteKatalog),
              outputType: selectedType,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildAnimatedSelectionCard(
            delay: 100,
            child: VisualEditorCards.buildOptionCard(
              context: context,
              label: 'Editorial\nStüdyo',
              icon: Icons.photo_camera_rounded,
              isSelected: selectedType == OutputType.editorialStudio,
              onTap: () => onTypeSelected(OutputType.editorialStudio),
              outputType: selectedType,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildAnimatedSelectionCard(
            delay: 200,
            child: VisualEditorCards.buildOptionCard(
              context: context,
              label: 'Dış\nMekan',
              icon: Icons.terrain_rounded,
              isSelected: selectedType == OutputType.disMekan,
              onTap: () => onTypeSelected(OutputType.disMekan),
              outputType: selectedType,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildAnimatedSelectionCard({
    required Widget child,
    int delay = 0,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        final clampedValue = value.clamp(0.0, 1.0);
        return Transform.scale(
          scale: 0.85 + (0.15 * value),
          child: Opacity(opacity: clampedValue, child: child),
        );
      },
      child: child,
    );
  }
}
