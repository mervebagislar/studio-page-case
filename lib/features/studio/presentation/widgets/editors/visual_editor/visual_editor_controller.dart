import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_state.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';

final visualEditorControllerProvider =
    NotifierProvider<VisualEditorController, VisualEditorState>(
  VisualEditorController.new,
);

class VisualEditorController extends Notifier<VisualEditorState> {
  @override
  VisualEditorState build() => VisualEditorState();

  void updateSelectedOutput(OutputType value) {
    state = state.copyWith(selectedOutput: value);
  }

  void updateSelectedModel(String? value) {
    state = state.copyWith(
      selectedModel: value,
      selectedEditorialAngle: value == 'Mankenli' && state.selectedOutput == OutputType.editorialStudio
          ? null
          : state.selectedEditorialAngle,
      selectedEditorialGender: value == 'Mankenli' ? null : state.selectedEditorialGender,
      selectedEditorialFraming: value == 'Mankenli' ? null : state.selectedEditorialFraming,
      selectedOutdoorGender: value == 'Mankensiz' && state.selectedOutput == OutputType.disMekan
          ? null
          : state.selectedOutdoorGender,
    );
  }

  void updateSelectedAspectRatio(String? value) {
    state = state.copyWith(selectedAspectRatio: value);
  }

  void toggleShootingAngle(String angle) {
    final next = Set<String>.from(state.selectedShootingAngles);
    if (next.contains(angle)) {
      next.remove(angle);
    } else {
      next.add(angle);
    }
    state = state.copyWith(selectedShootingAngles: next);
  }

  void updateSelectedBackground(String? value) {
    state = state.copyWith(
      selectedBackground: value,
      clearCustomBackgroundColor: value == 'Gri' || value == 'Beyaz',
      clearKendinBelirleBackgroundMode: value == 'Gri' || value == 'Beyaz',
    );
  }

  void clearBackground() {
    state = state.copyWith(
      selectedBackground: null,
      customBackgroundColor: null,
      kendinBelirleBackgroundMode: null,
    );
  }

  void updateKendinBelirleBackgroundMode(String? value) {
    state = state.copyWith(kendinBelirleBackgroundMode: value);
  }

  void updateSelectedPhotoStyle(String? value) {
    state = state.copyWith(selectedPhotoStyle: value);
  }

  void updateSelectedGender(String? value) {
    state = state.copyWith(selectedGender: value);
  }

  void updateSelectedObject(String? value) {
    state = state.copyWith(selectedObject: value);
  }

  void updateSelectedEditorialAngle(String? value) {
    state = state.copyWith(selectedEditorialAngle: value);
  }

  void setObjectModeObjeSec() {
    state = state.copyWith(
      selectedEditorialObjects: {},
      selectedObject: 'Obje Seç',
    );
  }

  void setObjectModeKendinBelirle() {
    state = state.copyWith(
      selectedEditorialObjects: {},
      selectedObject: 'Kendin Belirle',
    );
  }

  void toggleEditorialObject(String option, {int maxSelection = 2}) {
    final next = Set<String>.from(state.selectedEditorialObjects);
    if (next.contains(option)) {
      next.remove(option);
    } else if (next.length < maxSelection) {
      next.add(option);
    }
    state = state.copyWith(selectedEditorialObjects: next);
  }

  void clearEditorialObjectSelection() {
    state = state.copyWith(
      selectedEditorialObjects: {},
      selectedObject: null,
    );
  }

  void updateSelectedEditorialGender(String? value) {
    state = state.copyWith(selectedEditorialGender: value);
  }

  void updateSelectedEditorialFraming(String? value) {
    state = state.copyWith(selectedEditorialFraming: value);
  }

  void updateMankenData({
    String? bodyType,
    String? ethnicity,
    String? skinTone,
    String? hairColor,
    String? hairLength,
    String? ageGroup,
  }) {
    state = state.copyWith(
      mankenBodyType: bodyType ?? state.mankenBodyType,
      mankenEthnicity: ethnicity ?? state.mankenEthnicity,
      mankenSkinTone: skinTone ?? state.mankenSkinTone,
      mankenHairColor: hairColor ?? state.mankenHairColor,
      mankenHairLength: hairLength ?? state.mankenHairLength,
      mankenAgeGroup: ageGroup ?? state.mankenAgeGroup,
    );
  }

  void toggleShootingFrame(String frame) {
    final next = Set<String>.from(state.selectedShootingFrames);
    if (next.contains(frame)) {
      next.remove(frame);
    } else {
      next.add(frame);
    }
    state = state.copyWith(selectedShootingFrames: next);
  }

  void updateSelectedTimeOfDay(String? value) {
    state = state.copyWith(selectedTimeOfDay: value);
  }

  void setLocationModeMekanSec() {
    state = state.copyWith(
      selectedLocation: 'Mekan Seç',
      outdoorLocationCustomText: '',
    );
  }

  void setLocationModeKendinBelirle() {
    state = state.copyWith(
      selectedLocation: 'Kendin Belirle',
      selectedLocationSuggestion: null,
    );
  }

  void updateSelectedLocationSuggestion(String? value) {
    state = state.copyWith(selectedLocationSuggestion: value);
  }

  void updateOutdoorLocationCustomText(String value) {
    state = state.copyWith(outdoorLocationCustomText: value);
  }

  void clearLocationSelection() {
    state = state.copyWith(
      selectedLocation: null,
      selectedLocationSuggestion: null,
      outdoorLocationCustomText: '',
    );
  }

  void setOutdoorObjectModeObjeSec() {
    state = state.copyWith(
      selectedOutdoorObjects: {},
      selectedOutdoorObject: 'Obje Seç',
    );
  }

  void setOutdoorObjectModeKendinBelirle() {
    state = state.copyWith(
      selectedOutdoorObjects: {},
      selectedOutdoorObject: 'Kendin Belirle',
    );
  }

  void toggleOutdoorObject(String option, {int maxSelection = 2}) {
    final next = Set<String>.from(state.selectedOutdoorObjects);
    if (next.contains(option)) {
      next.remove(option);
    } else if (next.length < maxSelection) {
      next.add(option);
    }
    state = state.copyWith(selectedOutdoorObjects: next);
  }

  void clearOutdoorObjectSelection() {
    state = state.copyWith(
      selectedOutdoorObjects: {},
      selectedOutdoorObject: null,
    );
  }

  void updateSelectedOutdoorGender(String? value) {
    state = state.copyWith(selectedOutdoorGender: value);
  }

  void setUploadedImage(String label, File? file) {
    state = state.copyWith(
      uploadedImages: Map<String, File?>.from(state.uploadedImages)..[label] = file,
    );
  }

  /// Tüm yüklenen ürün fotoğraflarını temizler (Görsel editör yükleme alanı).
  void clearUploadedImages() {
    state = state.copyWith(
      uploadedImages: const {
        'Önden': null,
        'Yandan': null,
        'Arkadan': null,
        'Editorial': null,
        'Outdoor': null,
      },
    );
  }

  void setUploading(bool value) {
    state = state.copyWith(isUploading: value);
  }
}
