import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_chip.dart';

/// Instagram editörü günün zamanı seçici. Sadece UI; seçim ve callback view'dan geçilir.
class InstagramEditorTimeSection extends StatelessWidget {
  const InstagramEditorTimeSection({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.selectedTimeOfDay,
    required this.onTimeOfDaySelected,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  final String? selectedTimeOfDay;
  final ValueChanged<String> onTimeOfDaySelected;

  static const List<List<String>> _options = [
    ['Gün Ortası', 'Altın Saatler'],
    ['Gündoğumu', 'Kapalı Hava'],
    ['Karlı Hava', 'Yağmurlu Hava'],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _options.map((rowOptions) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Expanded(
                child: InstagramEditorChip(
                  label: rowOptions[0],
                  isSelected: selectedTimeOfDay == rowOptions[0],
                  onTap: () => onTimeOfDaySelected(rowOptions[0]),
                  theme: theme,
                  scheme: scheme,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InstagramEditorChip(
                  label: rowOptions[1],
                  isSelected: selectedTimeOfDay == rowOptions[1],
                  onTap: () => onTimeOfDaySelected(rowOptions[1]),
                  theme: theme,
                  scheme: scheme,
                  isDark: isDark,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
