import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/studio_snack_bars.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_action_bar.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_controller.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_state.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';
import 'package:studio_page_case/features/studio/state/generation/generation_type.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_controller.dart';

/// Ready checks and action bar builder. Business logic only; no UI except building the bar.
class VisualEditorReadyChecks {
  VisualEditorReadyChecks._();

  static bool isWebsiteKatalogReady(VisualEditorState s) {
    final hasImage =
        s.uploadedImages['Önden'] != null ||
        s.uploadedImages['Yandan'] != null ||
        s.uploadedImages['Arkadan'] != null;
    if (!hasImage) return false;
    if (s.selectedModel == null) return false;
    if (s.selectedModel == 'Mankenli' && s.selectedGender == null) return false;
    if (s.selectedModel == 'Mankensiz' && s.selectedPhotoStyle == null) return false;
    if (s.selectedAspectRatio == null) return false;
    if (s.selectedShootingAngles.isEmpty) return false;
    final shouldShowBackground =
        !((s.selectedOutput == OutputType.editorialStudio && s.selectedModel == 'Mankensiz') ||
            (s.selectedOutput == OutputType.disMekan && s.selectedModel == 'Mankensiz'));
    if (shouldShowBackground && s.selectedBackground == null) return false;
    return true;
  }

  static bool isEditorialReady(VisualEditorState s) {
    if (s.selectedModel == null) return false;
    if (s.selectedModel == 'Mankenli') {
      if (s.selectedEditorialGender == null) return false;
      if (s.selectedEditorialFraming == null) return false;
      if (s.selectedEditorialFraming != 'Full-body' && s.uploadedImages['Editorial'] == null) return false;
      return true;
    }
    if (s.selectedModel == 'Mankensiz') return s.selectedEditorialAngle != null;
    return false;
  }

  static bool isOutdoorReady(VisualEditorState s) {
    if (s.selectedModel == null) return false;
    if (s.selectedShootingFrames.isEmpty) return false;
    if (s.selectedTimeOfDay == null) return false;
    final locationOk =
        (s.selectedLocation == 'Mekan Seç' && s.selectedLocationSuggestion != null) ||
        (s.selectedLocation == 'Kendin Belirle' && s.outdoorLocationCustomText.trim().isNotEmpty);
    if (!locationOk) return false;
    if (s.selectedModel == 'Mankenli' && s.selectedOutdoorGender == null) return false;
    if (s.uploadedImages['Outdoor'] == null) return false;
    return true;
  }

  static bool canCreate(VisualEditorState state) {
    final isWebsiteKatalog = state.selectedOutput == OutputType.websiteKatalog;
    final isEditorial = state.selectedOutput == OutputType.editorialStudio;
    final isOutdoor = state.selectedOutput == OutputType.disMekan;
    return isWebsiteKatalog
        ? isWebsiteKatalogReady(state)
        : isEditorial
            ? isEditorialReady(state)
            : isOutdoor
                ? isOutdoorReady(state)
                : true;
  }

  static String? getNotReadyMessage(VisualEditorState state) {
    final isWebsiteKatalog = state.selectedOutput == OutputType.websiteKatalog;
    final isEditorial = state.selectedOutput == OutputType.editorialStudio;
    final isOutdoor = state.selectedOutput == OutputType.disMekan;
    if (isWebsiteKatalog) {
      return 'Lütfen ürün fotoğrafı yükleyin, manken seçin, en/boy oranı, çekim açıları ve arka planı belirleyin.';
    }
    if (isEditorial) {
      return 'Lütfen manken tipi, cinsiyet ve çekim kadrajını belirleyin. (Full-body dışında kadrajlarda ürün fotoğrafı zorunludur.)';
    }
    if (isOutdoor) {
      return 'Lütfen fotoğraf yükleyin, manken tipi, çekim kadrajı, günün zamanı ve mekan seçimini belirleyin. (Mankenli ise cinsiyet de gerekli)';
    }
    return null;
  }

  static Widget buildActionBar(
    BuildContext context,
    WidgetRef ref,
    VisualEditorState state,
    VisualEditorController notifier,
    LinearGradient gradient,
    Color shadowColor,
    bool mounted,
  ) {
    final canCreateNow = canCreate(state);
    final isWebsiteKatalog = state.selectedOutput == OutputType.websiteKatalog;
    final isEditorial = state.selectedOutput == OutputType.editorialStudio;
    final isOutdoor = state.selectedOutput == OutputType.disMekan;
    final String? createSubtitle =
        isWebsiteKatalog || isEditorial || isOutdoor ? '50 Kredi  ·  2 Görsel' : null;

    return VisualEditorActionBar(
      canCreate: canCreateNow,
      subtitle: createSubtitle,
      gradient: gradient,
      shadowColor: shadowColor,
      onTap: canCreateNow
          ? () {
              HapticFeedback.lightImpact();
              if (isWebsiteKatalog || isEditorial || isOutdoor) {
                final currentConfig = ref.read(studioControllerProvider).config;
                ref.read(studioControllerProvider.notifier).updateConfig(currentConfig.copyWith(count: 2));
              }
              ref.read(studioControllerProvider.notifier).generate(type: GenerationType.visual.value);
            }
          : () {
              if (mounted) {
                final msg = getNotReadyMessage(state);
                if (msg != null) StudioSnackBars.showError(context, msg);
              }
            },
    );
  }
}
