import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_location_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_constants.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart' show OutputType;

/// Instagram editörü mekan seçimi: Paylaşılan EditorLocationSection kullanır (Görsel editör ile aynı UI).
class InstagramEditorLocationSection extends StatelessWidget {
  const InstagramEditorLocationSection({
    super.key,
    required this.selectedLocation,
    required this.selectedLocationSuggestion,
    required this.locationCustomTextController,
    required this.onLocationModeMekanSec,
    required this.onLocationModeKendinBelirle,
    required this.onLocationSuggestionSelected,
    required this.onLocationCustomChanged,
    required this.onLocationClear,
  });

  final String? selectedLocation;
  final String? selectedLocationSuggestion;
  final TextEditingController locationCustomTextController;
  final VoidCallback onLocationModeMekanSec;
  final VoidCallback onLocationModeKendinBelirle;
  final ValueChanged<String?> onLocationSuggestionSelected;
  final ValueChanged<String> onLocationCustomChanged;
  final VoidCallback onLocationClear;

  @override
  Widget build(BuildContext context) {
    return EditorLocationSection(
      selectedLocation: selectedLocation,
      selectedLocationSuggestion: selectedLocationSuggestion,
      locationCustomTextController: locationCustomTextController,
      locationCategories: VisualEditorConstants.outdoorLocationCategories,
      outputType: OutputType.disMekan,
      onLocationModeMekanSec: onLocationModeMekanSec,
      onLocationModeKendinBelirle: onLocationModeKendinBelirle,
      onLocationSuggestionSelected: onLocationSuggestionSelected,
      onLocationCustomChanged: onLocationCustomChanged,
      onLocationClear: onLocationClear,
    );
  }
}
