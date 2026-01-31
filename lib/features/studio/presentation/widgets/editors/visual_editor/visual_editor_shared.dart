import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_background_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_clear_button.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';

/// Ortak UI parçaları: Clear button, colorToHex, Manken kartı, Arka plan seçici.
/// State view'da kalır; sadece UI + callback.
class VisualEditorShared {
  VisualEditorShared._();

  /// "Seçimi temizle" butonu. Paylaşılan [EditorClearButton] kullanır.
  static Widget buildClearButton(
    ThemeData theme,
    ColorScheme scheme,
    bool isDark,
    VoidCallback onTap,
  ) {
    return EditorClearButton(
      theme: theme,
      scheme: scheme,
      onTap: onTap,
    );
  }

  /// Color → hex string (örn. arka plan kartı için).
  static String colorToHex(Color color) {
    return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  }

  /// Arka plan seçici. Paylaşılan [EditorBackgroundSection] kullanır.
  static Widget buildBackgroundSection(
    BuildContext context, {
    required OutputType outputType,
    required String? selectedBackground,
    required Color? customBackgroundColor,
    required String? kendinBelirleBackgroundMode,
    required TextEditingController backgroundDescriptionController,
    required VoidCallback onBackgroundClear,
    required VoidCallback onBackgroundGriTap,
    required VoidCallback onBackgroundBeyazTap,
    required VoidCallback onBackgroundKendinBelirleTap,
    required VoidCallback onKendinBelirleModeKendinBelirle,
    required VoidCallback onKendinBelirleModeTRYPIX,
    required VoidCallback onBackgroundDescriptionChanged,
    required String Function(Color) colorToHex,
    required Widget Function(ThemeData theme, ColorScheme scheme, bool isDark, VoidCallback onTap) buildClearButton,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return EditorBackgroundSection(
      theme: theme,
      scheme: scheme,
      isDark: isDark,
      selectedBackground: selectedBackground,
      customBackgroundColor: customBackgroundColor,
      kendinBelirleBackgroundMode: kendinBelirleBackgroundMode,
      backgroundDescriptionController: backgroundDescriptionController,
      onBackgroundClear: onBackgroundClear,
      onBackgroundSelected: (v) {
        if (v == 'Gri') onBackgroundGriTap();
        else if (v == 'Beyaz') onBackgroundBeyazTap();
        else if (v == 'Kendin Belirle') onBackgroundKendinBelirleTap();
      },
      onKendinBelirleModeKendinBelirle: onKendinBelirleModeKendinBelirle,
      onKendinBelirleModeTRYPIX: onKendinBelirleModeTRYPIX,
      onBackgroundDescriptionChanged: onBackgroundDescriptionChanged,
      gradient: VisualEditorUtils.getSelectedGradient(outputType),
      accent: VisualEditorUtils.getShadowColor(outputType),
    );
  }
}

