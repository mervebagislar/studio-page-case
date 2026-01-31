import 'dart:io';
import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';

/// Visual editor form state. Testable; view only ref.watch + dispatch events.
class VisualEditorState {
  VisualEditorState({
    this.selectedOutput = OutputType.websiteKatalog,
    this.selectedModel = 'Mankenli',
    this.selectedAspectRatio,
    this.selectedShootingAngles = const {},
    this.selectedBackground,
    this.customBackgroundColor,
    this.kendinBelirleBackgroundMode,
    this.selectedPhotoStyle,
    this.selectedGender,
    this.selectedObject,
    this.selectedEditorialAngle,
    this.selectedEditorialObjects = const {},
    this.selectedEditorialGender,
    this.selectedEditorialFraming,
    this.selectedShootingFrames = const {},
    this.selectedTimeOfDay,
    this.selectedLocation,
    this.selectedLocationSuggestion,
    this.outdoorLocationCustomText = '',
    this.selectedOutdoorObject,
    this.selectedOutdoorObjects = const {},
    this.selectedOutdoorGender,
    this.mankenBodyType,
    this.mankenEthnicity,
    this.mankenSkinTone,
    this.mankenHairColor,
    this.mankenHairLength,
    this.mankenAgeGroup,
    this.isUploading = false,
    Map<String, File?>? uploadedImages,
  }) : uploadedImages = uploadedImages ?? _defaultUploadedImages;

  static final Map<String, File?> _defaultUploadedImages = {
    'Önden': null,
    'Yandan': null,
    'Arkadan': null,
    'Editorial': null,
    'Outdoor': null,
  };

  final OutputType selectedOutput;
  final String? selectedModel;
  final String? selectedAspectRatio;
  final Set<String> selectedShootingAngles;
  final String? selectedBackground;
  final Color? customBackgroundColor;
  final String? kendinBelirleBackgroundMode;
  final String? selectedPhotoStyle;
  final String? selectedGender;
  final String? selectedObject;
  final String? selectedEditorialAngle;
  final Set<String> selectedEditorialObjects;
  final String? selectedEditorialGender;
  final String? selectedEditorialFraming;
  final Set<String> selectedShootingFrames;
  final String? selectedTimeOfDay;
  final String? selectedLocation;
  final String? selectedLocationSuggestion;
  final String outdoorLocationCustomText;
  final String? selectedOutdoorObject;
  final Set<String> selectedOutdoorObjects;
  final String? selectedOutdoorGender;
  final String? mankenBodyType;
  final String? mankenEthnicity;
  final String? mankenSkinTone;
  final String? mankenHairColor;
  final String? mankenHairLength;
  final String? mankenAgeGroup;
  final bool isUploading;
  final Map<String, File?> uploadedImages;

  VisualEditorState copyWith({
    OutputType? selectedOutput,
    String? selectedModel,
    String? selectedAspectRatio,
    Set<String>? selectedShootingAngles,
    String? selectedBackground,
    Color? customBackgroundColor,
    String? kendinBelirleBackgroundMode,
    String? selectedPhotoStyle,
    String? selectedGender,
    String? selectedObject,
    String? selectedEditorialAngle,
    Set<String>? selectedEditorialObjects,
    String? selectedEditorialGender,
    String? selectedEditorialFraming,
    Set<String>? selectedShootingFrames,
    String? selectedTimeOfDay,
    String? selectedLocation,
    String? selectedLocationSuggestion,
    String? outdoorLocationCustomText,
    String? selectedOutdoorObject,
    Set<String>? selectedOutdoorObjects,
    String? selectedOutdoorGender,
    String? mankenBodyType,
    String? mankenEthnicity,
    String? mankenSkinTone,
    String? mankenHairColor,
    String? mankenHairLength,
    String? mankenAgeGroup,
    bool? isUploading,
    Map<String, File?>? uploadedImages,
    bool clearCustomBackgroundColor = false,
    bool clearKendinBelirleBackgroundMode = false,
  }) {
    return VisualEditorState(
      selectedOutput: selectedOutput ?? this.selectedOutput,
      selectedModel: selectedModel ?? this.selectedModel,
      selectedAspectRatio: selectedAspectRatio ?? this.selectedAspectRatio,
      selectedShootingAngles: selectedShootingAngles ?? Set.from(this.selectedShootingAngles),
      selectedBackground: selectedBackground ?? this.selectedBackground,
      customBackgroundColor: clearCustomBackgroundColor ? null : (customBackgroundColor ?? this.customBackgroundColor),
      kendinBelirleBackgroundMode: clearKendinBelirleBackgroundMode ? null : (kendinBelirleBackgroundMode ?? this.kendinBelirleBackgroundMode),
      selectedPhotoStyle: selectedPhotoStyle ?? this.selectedPhotoStyle,
      selectedGender: selectedGender ?? this.selectedGender,
      selectedObject: selectedObject ?? this.selectedObject,
      selectedEditorialAngle: selectedEditorialAngle ?? this.selectedEditorialAngle,
      selectedEditorialObjects: selectedEditorialObjects ?? Set.from(this.selectedEditorialObjects),
      selectedEditorialGender: selectedEditorialGender ?? this.selectedEditorialGender,
      selectedEditorialFraming: selectedEditorialFraming ?? this.selectedEditorialFraming,
      selectedShootingFrames: selectedShootingFrames ?? Set.from(this.selectedShootingFrames),
      selectedTimeOfDay: selectedTimeOfDay ?? this.selectedTimeOfDay,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      selectedLocationSuggestion: selectedLocationSuggestion ?? this.selectedLocationSuggestion,
      outdoorLocationCustomText: outdoorLocationCustomText ?? this.outdoorLocationCustomText,
      selectedOutdoorObject: selectedOutdoorObject ?? this.selectedOutdoorObject,
      selectedOutdoorObjects: selectedOutdoorObjects ?? Set.from(this.selectedOutdoorObjects),
      selectedOutdoorGender: selectedOutdoorGender ?? this.selectedOutdoorGender,
      mankenBodyType: mankenBodyType ?? this.mankenBodyType,
      mankenEthnicity: mankenEthnicity ?? this.mankenEthnicity,
      mankenSkinTone: mankenSkinTone ?? this.mankenSkinTone,
      mankenHairColor: mankenHairColor ?? this.mankenHairColor,
      mankenHairLength: mankenHairLength ?? this.mankenHairLength,
      mankenAgeGroup: mankenAgeGroup ?? this.mankenAgeGroup,
      isUploading: isUploading ?? this.isUploading,
      uploadedImages: uploadedImages ?? Map.from(this.uploadedImages),
    );
  }
}
