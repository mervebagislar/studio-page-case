import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_background_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_gender_row.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_object_mode_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_cards.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_object_selection_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_prompt_section.dart';

/// Editorial Stüdyo section builder parametreleri.
class EditorialSectionsParams {
  const EditorialSectionsParams({
    required this.getNextSectionIndex,
    required this.outputType,
    required this.selectedModel,
    required this.selectedEditorialAngle,
    required this.selectedObject,
    required this.selectedEditorialObjects,
    required this.editorialObjectCustomTextController,
    required this.editorialObjectCategories,
    required this.selectedBackground,
    required this.customBackgroundColor,
    required this.kendinBelirleBackgroundMode,
    required this.backgroundDescriptionController,
    required this.selectedEditorialGender,
    required this.selectedEditorialFraming,
    required this.onEditorialAngleSelected,
    required this.onObjectModeObjeSec,
    required this.onObjectModeKendinBelirle,
    required this.onObjectToggle,
    required this.onObjectCustomChanged,
    required this.onObjectClear,
    required this.onBackgroundSelected,
    required this.onBackgroundClear,
    required this.onKendinBelirleModeKendinBelirle,
    required this.onKendinBelirleModeTRYPIX,
    required this.onBackgroundDescriptionChanged,
    required this.onEditorialGenderSelected,
    required this.onEditorialFramingSelected,
    required this.colorToHex,
    required this.buildClearButton,
    required this.buildMankenCard,
  });

  final int Function() getNextSectionIndex;
  final OutputType outputType;
  final String? selectedModel;
  final String? selectedEditorialAngle;
  final String? selectedObject;
  final Set<String> selectedEditorialObjects;
  final TextEditingController editorialObjectCustomTextController;
  final Map<String, List<String>> editorialObjectCategories;
  final String? selectedBackground;
  final Color? customBackgroundColor;
  final String? kendinBelirleBackgroundMode;
  final TextEditingController backgroundDescriptionController;
  final String? selectedEditorialGender;
  final String? selectedEditorialFraming;
  final ValueChanged<String?> onEditorialAngleSelected;
  final VoidCallback onObjectModeObjeSec;
  final VoidCallback onObjectModeKendinBelirle;
  final ValueChanged<String> onObjectToggle;
  final ValueChanged<String> onObjectCustomChanged;
  final VoidCallback onObjectClear;
  final ValueChanged<String?> onBackgroundSelected;
  final VoidCallback onBackgroundClear;
  final VoidCallback onKendinBelirleModeKendinBelirle;
  final VoidCallback onKendinBelirleModeTRYPIX;
  final VoidCallback onBackgroundDescriptionChanged;
  final ValueChanged<String?> onEditorialGenderSelected;
  final ValueChanged<String?> onEditorialFramingSelected;
  final String Function(Color) colorToHex;
  final Widget Function(ThemeData theme, ColorScheme scheme, bool isDark, VoidCallback onTap) buildClearButton;
  final Widget Function(BuildContext context) buildMankenCard;
}

/// Editorial Stüdyo'ya özel bölümler: Mankensiz (açı, obje, arka plan); Mankenli (cinsiyet, kadraj, obje).
/// Sadece UI + callback; state view'da kalır.
class VisualEditorEditorialSections {
  VisualEditorEditorialSections._();

  static const List<String> _angleOptions = [
    'Flat lay',
    'Önden',
    '45°',
    'Üstten',
    'Makro',
    'Kendin Belirle',
  ];
  static const List<String> _framingOptions = [
    'Low angle',
    'High angle',
    'Medium shot',
    'Full-body',
  ];

  /// Editorial Stüdyo seçiliyse döndürülecek bölüm listesi.
  static List<Widget> build(BuildContext context, {required EditorialSectionsParams params}) {
    final List<Widget> sections = [];
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    if (params.selectedModel == 'Mankensiz') {
      sections.addAll([
        VisualEditorSection(
          index: params.getNextSectionIndex(),
          title: '5) Çekim açısı',
          subtitle: 'Görsel perspektifini seç',
          icon: Icons.videocam_rounded,
          outputType: params.outputType,
          child: _buildAngleContent(
            context: context,
            theme: theme,
            scheme: scheme,
            isDark: isDark,
            outputType: params.outputType,
            selectedEditorialAngle: params.selectedEditorialAngle,
            onEditorialAngleSelected: params.onEditorialAngleSelected,
            buildClearButton: params.buildClearButton,
          ),
        ),
        const SizedBox(height: 36),
        VisualEditorSection(
          index: params.getNextSectionIndex(),
          title: '6) Obje seçimi',
          subtitle: 'En fazla 2 obje ekleyebilirsin (opsiyonel)',
          icon: Icons.inventory_2_rounded,
          outputType: params.outputType,
          child: _buildEditorialObjectContent(
            context: context,
            theme: theme,
            scheme: scheme,
            isDark: isDark,
            outputType: params.outputType,
            selectedObject: params.selectedObject,
            selectedEditorialObjects: params.selectedEditorialObjects,
            editorialObjectCustomTextController: params.editorialObjectCustomTextController,
            editorialObjectCategories: params.editorialObjectCategories,
            onObjectModeObjeSec: params.onObjectModeObjeSec,
            onObjectModeKendinBelirle: params.onObjectModeKendinBelirle,
            onObjectToggle: params.onObjectToggle,
            onObjectCustomChanged: params.onObjectCustomChanged,
            onObjectClear: params.onObjectClear,
            buildClearButton: params.buildClearButton,
            showClearButton: true,
          ),
        ),
        const SizedBox(height: 36),
        VisualEditorSection(
          index: params.getNextSectionIndex(),
          title: '7) Arka plan',
          subtitle: 'Arka plan rengini belirle',
          icon: Icons.palette_rounded,
          outputType: params.outputType,
          child: _buildEditorialBackgroundContent(
            context: context,
            theme: theme,
            scheme: scheme,
            isDark: isDark,
            outputType: params.outputType,
            selectedBackground: params.selectedBackground,
            customBackgroundColor: params.customBackgroundColor,
            kendinBelirleBackgroundMode: params.kendinBelirleBackgroundMode,
            backgroundDescriptionController: params.backgroundDescriptionController,
            onBackgroundSelected: params.onBackgroundSelected,
            onBackgroundClear: params.onBackgroundClear,
            onKendinBelirleModeKendinBelirle: params.onKendinBelirleModeKendinBelirle,
            onKendinBelirleModeTRYPIX: params.onKendinBelirleModeTRYPIX,
            onBackgroundDescriptionChanged: params.onBackgroundDescriptionChanged,
            colorToHex: params.colorToHex,
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
          title: '5) Manken Cinsiyeti',
          subtitle: 'Kadın veya Erkek seç',
          icon: Icons.person_rounded,
          outputType: params.outputType,
          child: _buildEditorialGenderContent(
            context: context,
            outputType: params.outputType,
            selectedEditorialGender: params.selectedEditorialGender,
            onEditorialGenderSelected: params.onEditorialGenderSelected,
            buildMankenCard: params.buildMankenCard,
          ),
        ),
        const SizedBox(height: 36),
        VisualEditorSection(
          index: params.getNextSectionIndex(),
          title: '6) Çekim Kadrajı (Framing)',
          subtitle: 'Kadraj stilini seç',
          icon: Icons.camera_alt_rounded,
          outputType: params.outputType,
          child: _buildFramingContent(
            context: context,
            theme: theme,
            scheme: scheme,
            isDark: isDark,
            outputType: params.outputType,
            selectedEditorialFraming: params.selectedEditorialFraming,
            onEditorialFramingSelected: params.onEditorialFramingSelected,
            buildClearButton: params.buildClearButton,
          ),
        ),
        const SizedBox(height: 36),
        VisualEditorSection(
          index: params.getNextSectionIndex(),
          title: '7) Obje Seçimi',
          subtitle: 'Kompozisyona eklenecek objeleri seç',
          icon: Icons.shopping_bag_rounded,
          outputType: params.outputType,
          child: _buildEditorialObjectContent(
            context: context,
            theme: theme,
            scheme: scheme,
            isDark: isDark,
            outputType: params.outputType,
            selectedObject: params.selectedObject,
            selectedEditorialObjects: params.selectedEditorialObjects,
            editorialObjectCustomTextController: params.editorialObjectCustomTextController,
            editorialObjectCategories: params.editorialObjectCategories,
            onObjectModeObjeSec: params.onObjectModeObjeSec,
            onObjectModeKendinBelirle: params.onObjectModeKendinBelirle,
            onObjectToggle: params.onObjectToggle,
            onObjectCustomChanged: params.onObjectCustomChanged,
            onObjectClear: params.onObjectClear,
            buildClearButton: params.buildClearButton,
            showClearButton: false,
          ),
        ),
        const SizedBox(height: 36),
      ]);
    }

    return sections;
  }

  static Widget _buildAngleContent({
    required BuildContext context,
    required ThemeData theme,
    required ColorScheme scheme,
    required bool isDark,
    required OutputType outputType,
    required String? selectedEditorialAngle,
    required ValueChanged<String?> onEditorialAngleSelected,
    required Widget Function(ThemeData theme, ColorScheme scheme, bool isDark, VoidCallback onTap) buildClearButton,
  }) {
    return Column(
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _angleOptions.map((angle) {
            final isSelected = selectedEditorialAngle == angle;
            return VisualEditorCards.buildMultiSelectCard(
              context: context,
              label: angle,
              isSelected: isSelected,
              onTap: () => onEditorialAngleSelected(isSelected ? null : angle),
              outputType: outputType,
            );
          }).toList(),
        ),
        if (selectedEditorialAngle != null) ...[
          const SizedBox(height: 14),
          buildClearButton(theme, scheme, isDark, () => onEditorialAngleSelected(null)),
        ],
      ],
    );
  }

  static Widget _buildEditorialGenderContent({
    required BuildContext context,
    required OutputType outputType,
    required String? selectedEditorialGender,
    required ValueChanged<String?> onEditorialGenderSelected,
    required Widget Function(BuildContext context) buildMankenCard,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return EditorGenderRow(
      theme: theme,
      scheme: scheme,
      isDark: isDark,
      selectedGender: selectedEditorialGender,
      onGenderSelected: (v) => onEditorialGenderSelected(v),
      gradient: VisualEditorUtils.getSelectedGradient(outputType),
      accent: VisualEditorUtils.getShadowColor(outputType),
      trailingChild: buildMankenCard(context),
    );
  }

  static Widget _buildFramingContent({
    required BuildContext context,
    required ThemeData theme,
    required ColorScheme scheme,
    required bool isDark,
    required OutputType outputType,
    required String? selectedEditorialFraming,
    required ValueChanged<String?> onEditorialFramingSelected,
    required Widget Function(ThemeData theme, ColorScheme scheme, bool isDark, VoidCallback onTap) buildClearButton,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _framingOptions.map((f) {
            final isSelected = selectedEditorialFraming == f;
            return VisualEditorCards.buildMultiSelectCard(
              context: context,
              label: f,
              isSelected: isSelected,
              onTap: () => onEditorialFramingSelected(isSelected ? null : f),
              outputType: outputType,
            );
          }).toList(),
        ),
        if (selectedEditorialFraming != null) ...[
          const SizedBox(height: 14),
          buildClearButton(theme, scheme, isDark, () => onEditorialFramingSelected(null)),
        ],
      ],
    );
  }

  static Widget _buildEditorialObjectContent({
    required BuildContext context,
    required ThemeData theme,
    required ColorScheme scheme,
    required bool isDark,
    required OutputType outputType,
    required String? selectedObject,
    required Set<String> selectedEditorialObjects,
    required TextEditingController editorialObjectCustomTextController,
    required Map<String, List<String>> editorialObjectCategories,
    required VoidCallback onObjectModeObjeSec,
    required VoidCallback onObjectModeKendinBelirle,
    required ValueChanged<String> onObjectToggle,
    required ValueChanged<String> onObjectCustomChanged,
    required VoidCallback onObjectClear,
    required Widget Function(ThemeData theme, ColorScheme scheme, bool isDark, VoidCallback onTap) buildClearButton,
    required bool showClearButton,
  }) {
    final showClear = showClearButton &&
        (selectedEditorialObjects.isNotEmpty ||
            selectedObject != null ||
            editorialObjectCustomTextController.text.isNotEmpty);

    return EditorObjectModeSection(
      theme: theme,
      scheme: scheme,
      isDark: isDark,
      selectedMode: selectedObject,
      onObjeSecTap: onObjectModeObjeSec,
      onKendinBelirleTap: onObjectModeKendinBelirle,
      gradient: VisualEditorUtils.getSelectedGradient(outputType),
      accent: VisualEditorUtils.getShadowColor(outputType),
      showClear: showClear,
      onClear: onObjectClear,
      iconObjeSec: showClearButton ? Icons.category_rounded : Icons.category_outlined,
      iconKendinBelirle: showClearButton ? Icons.edit_rounded : Icons.edit_outlined,
      child: selectedObject == 'Obje Seç'
          ? VisualEditorObjectSelectionSection(
              categories: editorialObjectCategories,
              selectedIds: selectedEditorialObjects,
              outputType: outputType,
              maxSelection: 2,
              onToggle: onObjectToggle,
            )
          : selectedObject == 'Kendin Belirle'
              ? VisualEditorPromptSection(
                  controller: editorialObjectCustomTextController,
                  onChanged: onObjectCustomChanged,
                  hintText: 'Örn: Beyaz vazo, yeşil yapraklı bitki...',
                  label: 'Obje açıklaması',
                  maxLines: 2,
                )
              : const SizedBox.shrink(),
    );
  }

  static Widget _buildEditorialBackgroundContent({
    required BuildContext context,
    required ThemeData theme,
    required ColorScheme scheme,
    required bool isDark,
    required OutputType outputType,
    required String? selectedBackground,
    required Color? customBackgroundColor,
    required String? kendinBelirleBackgroundMode,
    required TextEditingController backgroundDescriptionController,
    required ValueChanged<String?> onBackgroundSelected,
    required VoidCallback onBackgroundClear,
    required VoidCallback onKendinBelirleModeKendinBelirle,
    required VoidCallback onKendinBelirleModeTRYPIX,
    required VoidCallback onBackgroundDescriptionChanged,
    required String Function(Color) colorToHex,
    required Widget Function(ThemeData theme, ColorScheme scheme, bool isDark, VoidCallback onTap) buildClearButton,
  }) {
    return EditorBackgroundSection(
      theme: theme,
      scheme: scheme,
      isDark: isDark,
      selectedBackground: selectedBackground,
      customBackgroundColor: customBackgroundColor,
      kendinBelirleBackgroundMode: kendinBelirleBackgroundMode,
      backgroundDescriptionController: backgroundDescriptionController,
      onBackgroundClear: onBackgroundClear,
      onBackgroundSelected: onBackgroundSelected,
      onKendinBelirleModeKendinBelirle: onKendinBelirleModeKendinBelirle,
      onKendinBelirleModeTRYPIX: onKendinBelirleModeTRYPIX,
      onBackgroundDescriptionChanged: onBackgroundDescriptionChanged,
      gradient: VisualEditorUtils.getSelectedGradient(outputType),
      accent: VisualEditorUtils.getShadowColor(outputType),
    );
  }
}
