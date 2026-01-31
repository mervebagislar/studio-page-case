import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_gender_row.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_cards.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';

/// Website Katalog section builder parametreleri.
class WebsiteSectionsParams {
  const WebsiteSectionsParams({
    required this.getNextSectionIndex,
    required this.outputType,
    required this.selectedModel,
    required this.selectedPhotoStyle,
    required this.selectedGender,
    required this.selectedShootingAngles,
    required this.onPhotoStyleSelected,
    required this.onGenderSelected,
    required this.onShootingAngleTap,
    required this.buildClearButton,
    required this.buildMankenCard,
  });

  final int Function() getNextSectionIndex;
  final OutputType outputType;
  final String? selectedModel;
  final String? selectedPhotoStyle;
  final String? selectedGender;
  final Set<String> selectedShootingAngles;
  final ValueChanged<String?> onPhotoStyleSelected;
  final ValueChanged<String?> onGenderSelected;
  final ValueChanged<String> onShootingAngleTap;
  final Widget Function(ThemeData theme, ColorScheme scheme, bool isDark, VoidCallback onTap) buildClearButton;
  final Widget Function(BuildContext context) buildMankenCard;
}

/// Website Katalog'a özel bölümler: Fon stili (Mankensiz), Manken özellikleri (Mankenli), Çekim açıları.
/// Sadece UI + callback; state view'da kalır.
class VisualEditorWebsiteSections {
  VisualEditorWebsiteSections._();

  /// Website Katalog seçiliyse döndürülecek bölüm listesi.
  static List<Widget> build(BuildContext context, {required WebsiteSectionsParams params}) {
    final List<Widget> sections = [];
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    if (params.selectedModel == 'Mankensiz') {
      sections.addAll([
        VisualEditorSection(
          index: params.getNextSectionIndex(),
          title: '5) Fon fotoğraf stili',
          subtitle: 'Canva Hayalet veya Standart stil seç',
          icon: Icons.auto_fix_high_rounded,
          outputType: params.outputType,
          child: _buildPhotoStyleContent(
            context: context,
            theme: theme,
            scheme: scheme,
            isDark: isDark,
            outputType: params.outputType,
            selectedPhotoStyle: params.selectedPhotoStyle,
            onPhotoStyleSelected: params.onPhotoStyleSelected,
            buildClearButton: params.buildClearButton,
          ),
        ),
        const SizedBox(height: 36),
      ]);
    }

    if (params.selectedModel == 'Mankenli') {
      sections.addAll([
        VisualEditorSection(
          index: params.getNextSectionIndex(),
          title: '5) Manken Özelliklerini Seç',
          subtitle: 'Manken cinsiyetini seç',
          icon: Icons.person_outline_rounded,
          outputType: params.outputType,
          child: _buildGenderContent(
            context: context,
            outputType: params.outputType,
            selectedGender: params.selectedGender,
            onGenderSelected: params.onGenderSelected,
            buildMankenCard: params.buildMankenCard,
          ),
        ),
        const SizedBox(height: 36),
      ]);
    }

    sections.addAll([
      VisualEditorSection(
        index: params.getNextSectionIndex(),
        title: '${params.selectedModel == "Mankensiz" ? "6" : "6"}) Çekim açıları',
        subtitle: 'Birden fazla açı seçebilirsin',
        icon: Icons.camera_alt_rounded,
        outputType: params.outputType,
        child: _buildShootingAnglesContent(
          context: context,
          outputType: params.outputType,
          selectedShootingAngles: params.selectedShootingAngles,
          onShootingAngleTap: params.onShootingAngleTap,
        ),
      ),
      const SizedBox(height: 36),
    ]);

    return sections;
  }

  static Widget _buildPhotoStyleContent({
    required BuildContext context,
    required ThemeData theme,
    required ColorScheme scheme,
    required bool isDark,
    required OutputType outputType,
    required String? selectedPhotoStyle,
    required ValueChanged<String?> onPhotoStyleSelected,
    required Widget Function(ThemeData theme, ColorScheme scheme, bool isDark, VoidCallback onTap) buildClearButton,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: VisualEditorCards.buildPhotoStyleCard(
                context: context,
                label: 'Canva Hayalet',
                icon: Icons.auto_fix_high_rounded,
                isSelected: selectedPhotoStyle == 'Canva Hayalet',
                onTap: () => onPhotoStyleSelected('Canva Hayalet'),
                outputType: outputType,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: VisualEditorCards.buildPhotoStyleCard(
                context: context,
                label: 'Standart',
                icon: Icons.photo_camera_rounded,
                isSelected: selectedPhotoStyle == 'Standart',
                onTap: () => onPhotoStyleSelected('Standart'),
                outputType: outputType,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(child: SizedBox()),
          ],
        ),
        if (selectedPhotoStyle != null) ...[
          const SizedBox(height: 14),
          buildClearButton(theme, scheme, isDark, () => onPhotoStyleSelected(null)),
        ],
      ],
    );
  }

  static Widget _buildGenderContent({
    required BuildContext context,
    required OutputType outputType,
    required String? selectedGender,
    required ValueChanged<String?> onGenderSelected,
    required Widget Function(BuildContext context) buildMankenCard,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return EditorGenderRow(
      theme: theme,
      scheme: scheme,
      isDark: isDark,
      selectedGender: selectedGender,
      onGenderSelected: (v) => onGenderSelected(v),
      gradient: VisualEditorUtils.getSelectedGradient(outputType),
      accent: VisualEditorUtils.getShadowColor(outputType),
      trailingChild: buildMankenCard(context),
    );
  }

  static Widget _buildShootingAnglesContent({
    required BuildContext context,
    required OutputType outputType,
    required Set<String> selectedShootingAngles,
    required ValueChanged<String> onShootingAngleTap,
  }) {
    const angles = ['Önden', 'Yandan', 'Çapraz', 'Arkadan'];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: angles.map((angle) {
        final isSelected = selectedShootingAngles.contains(angle);
        return VisualEditorCards.buildMultiSelectCard(
          context: context,
          label: angle,
          isSelected: isSelected,
          onTap: () => onShootingAngleTap(angle),
          outputType: outputType,
        );
      }).toList(),
    );
  }
}
