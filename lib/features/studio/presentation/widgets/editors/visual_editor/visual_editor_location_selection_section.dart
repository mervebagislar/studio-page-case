import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_cards.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';

/// Kategorili mekan seçimi: başlık + "Seçim: 0/1 veya 1/1" + kategori başlıkları, tek seçim.
/// Sadece UI + callback; state parent'ta kalır.
class VisualEditorLocationSelectionSection extends StatelessWidget {
  final Map<String, List<String>> categories;
  final String? selectedLocation;
  final ValueChanged<String?> onLocationSelected;
  final OutputType outputType;

  const VisualEditorLocationSelectionSection({
    super.key,
    required this.categories,
    required this.selectedLocation,
    required this.onLocationSelected,
    required this.outputType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final hasSelection = selectedLocation != null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          'Mekan Seçimi',
          style: theme.textTheme.titleMedium?.copyWith(
            color: scheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Kategoriye göre mekan seçin. En fazla 1 seçim yapabilirsiniz.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Kategoriler',
          style: theme.textTheme.titleSmall?.copyWith(
            color: scheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Seçim: ${hasSelection ? 1 : 0} / 1',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        ...categories.entries.map((entry) {
          final categoryName = entry.key;
          final items = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: items.map((loc) {
                    final isSelected = selectedLocation == loc;
                    return VisualEditorCards.buildMultiSelectCard(
                      context: context,
                      label: loc,
                      isSelected: isSelected,
                      onTap: () => onLocationSelected(isSelected ? null : loc),
                      outputType: outputType,
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
