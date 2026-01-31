import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_cards.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';

/// Kategorili obje seçimi: başlık + "Seçim: n / max" + kategori başlıkları ve çoklu seçim kartları.
/// Sadece UI + callback; state parent'ta kalır.
class VisualEditorObjectSelectionSection extends StatelessWidget {
  final Map<String, List<String>> categories;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggle;
  final OutputType outputType;
  final int maxSelection;

  const VisualEditorObjectSelectionSection({
    super.key,
    required this.categories,
    required this.selectedIds,
    required this.onToggle,
    required this.outputType,
    this.maxSelection = 2,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final count = selectedIds.length;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          'Objeleri Seç',
          style: theme.textTheme.titleMedium?.copyWith(
            color: scheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Kategoriye göre objeleri işaretleyin. Maksimum $maxSelection öğe seçebilirsiniz.',
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
          'Seçim: $count / $maxSelection',
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
                  children: items.map((option) {
                    final isSelected = selectedIds.contains(option);
                    final canAdd = count < maxSelection || isSelected;
                    return VisualEditorCards.buildMultiSelectCard(
                      context: context,
                      label: option,
                      isSelected: isSelected,
                      onTap: canAdd
                          ? () => onToggle(option)
                          : () {},
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
