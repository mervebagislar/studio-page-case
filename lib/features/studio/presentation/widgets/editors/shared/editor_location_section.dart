import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_cards.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_location_selection_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_prompt_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_shared.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart' show OutputType;

/// Tüm editörlerde ortak mekan seçimi: Mekan Seç / Kendin Belirle, kategorili liste veya serbest metin, temizle.
/// Görsel editör (Dış Mekan) ve Instagram editörü bu widget'ı kullanır.
class EditorLocationSection extends StatelessWidget {
  const EditorLocationSection({
    super.key,
    required this.selectedLocation,
    required this.selectedLocationSuggestion,
    required this.locationCustomTextController,
    required this.locationCategories,
    required this.outputType,
    required this.onLocationModeMekanSec,
    required this.onLocationModeKendinBelirle,
    required this.onLocationSuggestionSelected,
    required this.onLocationCustomChanged,
    required this.onLocationClear,
  });

  final String? selectedLocation;
  final String? selectedLocationSuggestion;
  final TextEditingController locationCustomTextController;
  final Map<String, List<String>> locationCategories;
  final OutputType outputType;
  final VoidCallback onLocationModeMekanSec;
  final VoidCallback onLocationModeKendinBelirle;
  final ValueChanged<String?> onLocationSuggestionSelected;
  final ValueChanged<String> onLocationCustomChanged;
  final VoidCallback onLocationClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final showClear = selectedLocation != null ||
        selectedLocationSuggestion != null ||
        locationCustomTextController.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: VisualEditorCards.buildHorizontalOptionCard(
                context: context,
                label: 'Mekan Seç',
                icon: Icons.location_on_rounded,
                isSelected: selectedLocation == 'Mekan Seç',
                onTap: onLocationModeMekanSec,
                outputType: outputType,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: VisualEditorCards.buildHorizontalOptionCard(
                context: context,
                label: 'Kendin Belirle',
                icon: Icons.edit_location_rounded,
                isSelected: selectedLocation == 'Kendin Belirle',
                onTap: onLocationModeKendinBelirle,
                outputType: outputType,
              ),
            ),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: selectedLocation == 'Mekan Seç'
              ? VisualEditorLocationSelectionSection(
                  categories: locationCategories,
                  selectedLocation: selectedLocationSuggestion,
                  onLocationSelected: onLocationSuggestionSelected,
                  outputType: outputType,
                )
              : selectedLocation == 'Kendin Belirle'
                  ? VisualEditorPromptSection(
                      controller: locationCustomTextController,
                      onChanged: onLocationCustomChanged,
                      hintText: 'Örn: Minimalist beyaz stüdyo, doğal ışık...',
                      label: 'Mekan açıklaması',
                      maxLines: 2,
                    )
                  : const SizedBox.shrink(),
        ),
        if (showClear) ...[
          const SizedBox(height: 14),
          VisualEditorShared.buildClearButton(
            theme,
            scheme,
            isDark,
            onLocationClear,
          ),
        ],
      ],
    );
  }
}
