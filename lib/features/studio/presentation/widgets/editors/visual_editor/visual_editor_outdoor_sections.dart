import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_gender_row.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_location_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_object_mode_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_cards.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_object_selection_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_prompt_section.dart';

/// Dış Mekan section builder parametreleri.
class OutdoorSectionsParams {
  const OutdoorSectionsParams({
    required this.getNextSectionIndex,
    required this.outputType,
    required this.selectedModel,
    required this.selectedOutdoorGender,
    required this.selectedShootingFrames,
    required this.selectedTimeOfDay,
    required this.selectedLocation,
    required this.selectedLocationSuggestion,
    required this.locationCustomTextController,
    required this.locationCategories,
    required this.selectedOutdoorObject,
    required this.selectedOutdoorObjects,
    required this.objectCustomTextController,
    required this.objectCategories,
    required this.onOutdoorGenderSelected,
    required this.onShootingFrameTap,
    required this.onTimeOfDaySelected,
    required this.onLocationModeMekanSec,
    required this.onLocationModeKendinBelirle,
    required this.onLocationSuggestionSelected,
    required this.onLocationCustomChanged,
    required this.onLocationClear,
    required this.onOutdoorObjectModeObjeSec,
    required this.onOutdoorObjectModeKendinBelirle,
    required this.onOutdoorObjectToggle,
    required this.onOutdoorObjectCustomChanged,
    required this.onOutdoorObjectClear,
    required this.buildClearButton,
    required this.buildMankenCard,
  });

  final int Function() getNextSectionIndex;
  final OutputType outputType;
  final String? selectedModel;
  final String? selectedOutdoorGender;
  final Set<String> selectedShootingFrames;
  final String? selectedTimeOfDay;
  final String? selectedLocation;
  final String? selectedLocationSuggestion;
  final TextEditingController locationCustomTextController;
  final Map<String, List<String>> locationCategories;
  final String? selectedOutdoorObject;
  final Set<String> selectedOutdoorObjects;
  final TextEditingController objectCustomTextController;
  final Map<String, List<String>> objectCategories;
  final ValueChanged<String?> onOutdoorGenderSelected;
  final ValueChanged<String> onShootingFrameTap;
  final ValueChanged<String?> onTimeOfDaySelected;
  final VoidCallback onLocationModeMekanSec;
  final VoidCallback onLocationModeKendinBelirle;
  final ValueChanged<String?> onLocationSuggestionSelected;
  final ValueChanged<String> onLocationCustomChanged;
  final VoidCallback onLocationClear;
  final VoidCallback onOutdoorObjectModeObjeSec;
  final VoidCallback onOutdoorObjectModeKendinBelirle;
  final ValueChanged<String> onOutdoorObjectToggle;
  final ValueChanged<String> onOutdoorObjectCustomChanged;
  final VoidCallback onOutdoorObjectClear;
  final Widget Function(ThemeData theme, ColorScheme scheme, bool isDark, VoidCallback onTap) buildClearButton;
  final Widget Function(BuildContext context) buildMankenCard;
}

/// Dış Mekan'a özel bölümler: Manken cinsiyeti, Çekim kadrajı, Obje seçimi (Mankensiz),
/// Günün zamanı, Mekan seçimi. Sadece UI + callback; state view'da kalır.
class VisualEditorOutdoorSections {
  VisualEditorOutdoorSections._();

  static const List<String> _shootingFrames = ['Yan', 'Çapraz', 'Arka', 'Ön'];
  static const List<String> _timeOfDayOptions = [
    'Gün Ortası',
    'Altın Saatler',
    'Gündoğumu',
    'Kapalı Hava',
    'Karlı Hava',
    'Yağmurlu Hava',
  ];

  /// Dış Mekan seçiliyse döndürülecek bölüm listesi.
  static List<Widget> build(BuildContext context, {required OutdoorSectionsParams params}) {
    final List<Widget> sections = [];
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    if (params.selectedModel == 'Mankenli') {
      sections.addAll([
        VisualEditorSection(
          index: params.getNextSectionIndex(),
          title: '5) Manken Cinsiyeti',
          subtitle: 'Kadın veya Erkek seç',
          icon: Icons.person_rounded,
          outputType: params.outputType,
          child: _buildOutdoorGenderContent(
            context: context,
            outputType: params.outputType,
            selectedOutdoorGender: params.selectedOutdoorGender,
            onOutdoorGenderSelected: params.onOutdoorGenderSelected,
            buildMankenCard: params.buildMankenCard,
          ),
        ),
        const SizedBox(height: 36),
      ]);
    }

    sections.addAll([
      VisualEditorSection(
        index: params.getNextSectionIndex(),
        title: '${params.selectedModel == "Mankensiz" ? "5" : "6"}) Çekim Kadrajı',
        subtitle: 'Çekim açılarını seç',
        icon: Icons.panorama_rounded,
        outputType: params.outputType,
        child: _buildShootingFramesContent(
          context: context,
          outputType: params.outputType,
          selectedShootingFrames: params.selectedShootingFrames,
          onShootingFrameTap: params.onShootingFrameTap,
        ),
      ),
      const SizedBox(height: 36),
    ]);

    if (params.selectedModel == 'Mankensiz') {
      sections.addAll([
        VisualEditorSection(
          index: params.getNextSectionIndex(),
          title: '6) Obje seçimi',
          subtitle: 'En fazla 2 obje ekleyebilirsin (opsiyonel)',
          icon: Icons.category_rounded,
          outputType: params.outputType,
          child: _buildOutdoorObjectContent(
            context: context,
            theme: theme,
            scheme: scheme,
            isDark: isDark,
            outputType: params.outputType,
            selectedOutdoorObject: params.selectedOutdoorObject,
            selectedOutdoorObjects: params.selectedOutdoorObjects,
            objectCustomTextController: params.objectCustomTextController,
            objectCategories: params.objectCategories,
            onOutdoorObjectModeObjeSec: params.onOutdoorObjectModeObjeSec,
            onOutdoorObjectModeKendinBelirle: params.onOutdoorObjectModeKendinBelirle,
            onOutdoorObjectToggle: params.onOutdoorObjectToggle,
            onOutdoorObjectCustomChanged: params.onOutdoorObjectCustomChanged,
            onOutdoorObjectClear: params.onOutdoorObjectClear,
            buildClearButton: params.buildClearButton,
        ),
      ),
      const SizedBox(height: 36),
      ]);
    }

    sections.addAll([
      VisualEditorSection(
        index: params.getNextSectionIndex(),
        title: '${params.selectedModel == "Mankensiz" ? "7" : "7"}) Günün Zamanı',
        subtitle: 'Işık koşullarını belirle',
        icon: Icons.wb_sunny_rounded,
        outputType: params.outputType,
        child: _buildTimeOfDayContent(
          context: context,
          theme: theme,
          scheme: scheme,
          isDark: isDark,
          outputType: params.outputType,
          selectedTimeOfDay: params.selectedTimeOfDay,
          onTimeOfDaySelected: params.onTimeOfDaySelected,
          buildClearButton: params.buildClearButton,
        ),
      ),
      const SizedBox(height: 36),
      VisualEditorSection(
        index: params.getNextSectionIndex(),
        title: '${params.selectedModel == "Mankensiz" ? "8" : "8"}) Mekan Seçimi',
        subtitle: 'Çekim lokasyonunu seç',
        icon: Icons.place_rounded,
        outputType: params.outputType,
        child: _buildLocationContent(
          context: context,
          outputType: params.outputType,
          selectedLocation: params.selectedLocation,
          selectedLocationSuggestion: params.selectedLocationSuggestion,
          locationCustomTextController: params.locationCustomTextController,
          locationCategories: params.locationCategories,
          onLocationModeMekanSec: params.onLocationModeMekanSec,
          onLocationModeKendinBelirle: params.onLocationModeKendinBelirle,
          onLocationSuggestionSelected: params.onLocationSuggestionSelected,
          onLocationCustomChanged: params.onLocationCustomChanged,
          onLocationClear: params.onLocationClear,
        ),
      ),
      const SizedBox(height: 36),
    ]);

    return sections;
  }

  static Widget _buildOutdoorGenderContent({
    required BuildContext context,
    required OutputType outputType,
    required String? selectedOutdoorGender,
    required ValueChanged<String?> onOutdoorGenderSelected,
    required Widget Function(BuildContext context) buildMankenCard,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return EditorGenderRow(
      theme: theme,
      scheme: scheme,
      isDark: isDark,
      selectedGender: selectedOutdoorGender,
      onGenderSelected: (v) => onOutdoorGenderSelected(v),
      gradient: VisualEditorUtils.getSelectedGradient(outputType),
      accent: VisualEditorUtils.getShadowColor(outputType),
      trailingChild: buildMankenCard(context),
    );
  }

  static Widget _buildShootingFramesContent({
    required BuildContext context,
    required OutputType outputType,
    required Set<String> selectedShootingFrames,
    required ValueChanged<String> onShootingFrameTap,
  }) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _shootingFrames.map((frame) {
        final isSelected = selectedShootingFrames.contains(frame);
        return VisualEditorCards.buildMultiSelectCard(
          context: context,
          label: frame,
          isSelected: isSelected,
          onTap: () => onShootingFrameTap(frame),
          outputType: outputType,
        );
      }).toList(),
    );
  }

  static Widget _buildTimeOfDayContent({
    required BuildContext context,
    required ThemeData theme,
    required ColorScheme scheme,
    required bool isDark,
    required OutputType outputType,
    required String? selectedTimeOfDay,
    required ValueChanged<String?> onTimeOfDaySelected,
    required Widget Function(ThemeData theme, ColorScheme scheme, bool isDark, VoidCallback onTap) buildClearButton,
  }) {
    return Column(
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _timeOfDayOptions.map((time) {
            final isSelected = selectedTimeOfDay == time;
            return VisualEditorCards.buildMultiSelectCard(
              context: context,
              label: time,
              isSelected: isSelected,
              onTap: () => onTimeOfDaySelected(time),
              outputType: outputType,
            );
          }).toList(),
        ),
        if (selectedTimeOfDay != null) ...[
          const SizedBox(height: 14),
          buildClearButton(theme, scheme, isDark, () => onTimeOfDaySelected(null)),
        ],
      ],
    );
  }

  static Widget _buildLocationContent({
    required BuildContext context,
    required OutputType outputType,
    required String? selectedLocation,
    required String? selectedLocationSuggestion,
    required TextEditingController locationCustomTextController,
    required Map<String, List<String>> locationCategories,
    required VoidCallback onLocationModeMekanSec,
    required VoidCallback onLocationModeKendinBelirle,
    required ValueChanged<String?> onLocationSuggestionSelected,
    required ValueChanged<String> onLocationCustomChanged,
    required VoidCallback onLocationClear,
  }) {
    return EditorLocationSection(
      selectedLocation: selectedLocation,
      selectedLocationSuggestion: selectedLocationSuggestion,
      locationCustomTextController: locationCustomTextController,
      locationCategories: locationCategories,
      outputType: outputType,
      onLocationModeMekanSec: onLocationModeMekanSec,
      onLocationModeKendinBelirle: onLocationModeKendinBelirle,
      onLocationSuggestionSelected: onLocationSuggestionSelected,
      onLocationCustomChanged: onLocationCustomChanged,
      onLocationClear: onLocationClear,
    );
  }

  static Widget _buildOutdoorObjectContent({
    required BuildContext context,
    required ThemeData theme,
    required ColorScheme scheme,
    required bool isDark,
    required OutputType outputType,
    required String? selectedOutdoorObject,
    required Set<String> selectedOutdoorObjects,
    required TextEditingController objectCustomTextController,
    required Map<String, List<String>> objectCategories,
    required VoidCallback onOutdoorObjectModeObjeSec,
    required VoidCallback onOutdoorObjectModeKendinBelirle,
    required ValueChanged<String> onOutdoorObjectToggle,
    required ValueChanged<String> onOutdoorObjectCustomChanged,
    required VoidCallback onOutdoorObjectClear,
    required Widget Function(ThemeData theme, ColorScheme scheme, bool isDark, VoidCallback onTap) buildClearButton,
  }) {
    final showClear = selectedOutdoorObjects.isNotEmpty ||
        selectedOutdoorObject != null ||
        objectCustomTextController.text.isNotEmpty;

    return EditorObjectModeSection(
      theme: theme,
      scheme: scheme,
      isDark: isDark,
      selectedMode: selectedOutdoorObject,
      onObjeSecTap: onOutdoorObjectModeObjeSec,
      onKendinBelirleTap: onOutdoorObjectModeKendinBelirle,
      gradient: VisualEditorUtils.getSelectedGradient(outputType),
      accent: VisualEditorUtils.getShadowColor(outputType),
      showClear: showClear,
      onClear: onOutdoorObjectClear,
      child: selectedOutdoorObject == 'Obje Seç'
          ? VisualEditorObjectSelectionSection(
              categories: objectCategories,
              selectedIds: selectedOutdoorObjects,
              outputType: outputType,
              maxSelection: 2,
              onToggle: onOutdoorObjectToggle,
            )
          : selectedOutdoorObject == 'Kendin Belirle'
              ? VisualEditorPromptSection(
                  controller: objectCustomTextController,
                  onChanged: onOutdoorObjectCustomChanged,
                  hintText: 'Örn: Beyaz vazo, yeşil yapraklı bitki...',
                  label: 'Obje açıklaması',
                  maxLines: 2,
                )
              : const SizedBox.shrink(),
    );
  }
}
