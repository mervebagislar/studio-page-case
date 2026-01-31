import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_aspect_ratio_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_model_type_row.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';

/// Görsel editör konfigürasyonu: aspect ratio ve model seçimi.
/// Sadece UI + callback; state parent'ta kalır.
class VisualEditorConfigurationSection extends StatelessWidget {
  final String? selectedAspectRatio;
  final ValueChanged<String?> onAspectRatioSelected;
  final String? selectedModel;
  final ValueChanged<String?> onModelSelected;
  final OutputType outputType;

  /// Gösterilecek kısım: sadece model, sadece aspect ratio veya ikisi.
  final bool showModelSelector;
  final bool showAspectRatioSelector;

  const VisualEditorConfigurationSection({
    super.key,
    required this.selectedAspectRatio,
    required this.onAspectRatioSelected,
    required this.selectedModel,
    required this.onModelSelected,
    required this.outputType,
    this.showModelSelector = true,
    this.showAspectRatioSelector = true,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (showModelSelector) {
      children.add(_buildModelSelector(context));
      if (showAspectRatioSelector) {
        children.add(const SizedBox(height: 36));
      }
    }

    if (showAspectRatioSelector) {
      children.add(_buildAspectRatioSelector(context));
    }

    if (children.isEmpty) return const SizedBox.shrink();
    if (children.length == 1) return children.single;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  Widget _buildModelSelector(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return EditorModelTypeRow(
      theme: theme,
      scheme: scheme,
      isDark: isDark,
      selectedModel: selectedModel,
      onModelSelected: onModelSelected,
      gradient: VisualEditorUtils.getSelectedGradient(outputType),
      accent: VisualEditorUtils.getShadowColor(outputType),
    );
  }

  Widget _buildAspectRatioSelector(BuildContext context) {
    return EditorAspectRatioSection(
      selectedAspectRatio: selectedAspectRatio,
      onAspectRatioSelected: onAspectRatioSelected,
      outputType: outputType,
    );
  }
}
