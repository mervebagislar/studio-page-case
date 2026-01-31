import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studio_page_case/features/studio/state/selection/selected_images_controller.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_scaffold.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/manken_modal_data.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_manken_card.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_website_sections.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_editorial_sections.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_outdoor_sections.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_shared.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_header.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_animated_background.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_main_content.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_controller.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_state.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_constants.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_modals.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_ready_checks.dart';

export 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart'
    show OutputType;

/// Visual editor: form state in controller; view only watches and dispatches events.
class VisualEditorView extends ConsumerStatefulWidget {
  const VisualEditorView({super.key});

  @override
  ConsumerState<VisualEditorView> createState() => _VisualEditorViewState();
}

class _VisualEditorViewState extends ConsumerState<VisualEditorView>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  /// TextEditingController'lar view'da kalır; clear işleminde view temizler.
  final TextEditingController _backgroundDescriptionController =
      TextEditingController();
  final TextEditingController _editorialObjectCustomTextController =
      TextEditingController();
  final TextEditingController _outdoorLocationCustomTextController =
      TextEditingController();
  final TextEditingController _outdoorObjectCustomTextController =
      TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  // Animation controllers (UI-only; kept in view)
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _headerController;
  late AnimationController _shimmerController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutCubic),
    );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _editorialObjectCustomTextController.dispose();
    _outdoorLocationCustomTextController.dispose();
    _outdoorObjectCustomTextController.dispose();
    _backgroundDescriptionController.dispose();
    _headerController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  Color _shadowColor(VisualEditorState s) =>
      VisualEditorUtils.getShadowColor(s.selectedOutput);
  LinearGradient _gradient(VisualEditorState s) =>
      VisualEditorUtils.getSelectedGradient(s.selectedOutput);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(visualEditorControllerProvider);
    final notifier = ref.read(visualEditorControllerProvider.notifier);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final body = AnimatedBuilder(
      animation: _fadeController,
      builder: (context, _) {
        return Opacity(
          opacity: _fadeController.value.clamp(0.0, 1.0),
          child: SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  VisualEditorHeader(
                    theme: theme,
                    scheme: scheme,
                    headerController: _headerController,
                    gradient: _gradient(state),
                    shadowColor: _shadowColor(state),
                  ),
                  VisualEditorMainContent(
                    theme: theme,
                    scheme: scheme,
                    isDark: isDark,
                    selectedOutput: state.selectedOutput,
                    onOutputTypeSelected: (v) =>
                        notifier.updateSelectedOutput(v),
                    selectedAspectRatio: state.selectedAspectRatio,
                    onAspectRatioSelected: (v) =>
                        notifier.updateSelectedAspectRatio(v),
                    selectedModel: state.selectedModel,
                    onModelSelected: (v) => notifier.updateSelectedModel(v),
                    previewImagePath: VisualEditorUtils.getPreviewImagePath(
                      state.selectedOutput,
                      state.selectedModel,
                    ),
                    modelLabel: state.selectedModel == null
                        ? 'Seçim yapın'
                        : state.selectedModel == 'Mankenli'
                        ? 'Mankenli'
                        : 'Mankensiz',
                    shadowColor: _shadowColor(state),
                    gradient: _gradient(state),
                    hideProductPhotoSection:
                        state.selectedOutput == OutputType.editorialStudio &&
                        state.selectedEditorialFraming == 'Full-body',
                    uploadedImages: state.uploadedImages,
                    isUploading: state.isUploading,
                    shimmerController: _shimmerController,
                    hasUploadedImages:
                        state.uploadedImages.values.any((f) => f != null),
                    buildClearUploadButton:
                        (theme, scheme, isDark, onTap) =>
                            VisualEditorShared.buildClearButton(
                              theme,
                              scheme,
                              isDark,
                              onTap,
                            ),
                    onClearUpload: () {
                      final currentState =
                          ref.read(visualEditorControllerProvider);
                      final labels =
                          currentState.uploadedImages.keys.toList();
                      notifier.clearUploadedImages();
                      for (final label in labels) {
                        ref
                            .read(selectedImagesControllerProvider.notifier)
                            .removeImage(label);
                      }
                    },
                    onUploadTap: (label) {
                      if (label == 'Editorial') {
                        VisualEditorModals.showEditorialUpload(
                          context,
                          ref,
                          _pickImage,
                        );
                      } else if (label == 'Outdoor') {
                        VisualEditorModals.showOutdoorUpload(
                          context,
                          ref,
                          _pickImage,
                        );
                      } else {
                        VisualEditorModals.showWebsiteUpload(
                          context,
                          ref,
                          label,
                          _pickImage,
                        );
                      }
                    },
                    conditionalSections: _buildConditionalSections(
                      state,
                      notifier,
                    ),
                    createActionBar: VisualEditorReadyChecks.buildActionBar(
                      context,
                      ref,
                      state,
                      notifier,
                      _gradient(state),
                      _shadowColor(state),
                      mounted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    return EditorScaffold(
      backgroundColor: scheme.surface,
      background: VisualEditorAnimatedBackground(
        scheme: scheme,
        isDark: isDark,
        shadowColor: _shadowColor(state),
      ),
      body: body,
    );
  }

  // ========== UI COMPONENTS ==========

  Widget _buildMankenCard(
    BuildContext context, {
    required VisualEditorState state,
    required VisualEditorController notifier,
    required LinearGradient gradient,
    required Color accent,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return EditorMankenCard(
      theme: theme,
      scheme: scheme,
      isDark: isDark,
      initialData: MankenModalData(
        bodyType: state.mankenBodyType,
        ethnicity: state.mankenEthnicity,
        skinTone: state.mankenSkinTone,
        hairColor: state.mankenHairColor,
        hairLength: state.mankenHairLength,
        ageGroup: state.mankenAgeGroup,
      ),
      gradient: gradient,
      accent: accent,
      onSave: (data) => notifier.updateMankenData(
        bodyType: data.bodyType,
        ethnicity: data.ethnicity,
        skinTone: data.skinTone,
        hairColor: data.hairColor,
        hairLength: data.hairLength,
        ageGroup: data.ageGroup,
      ),
    );
  }

  List<Widget> _buildConditionalSections(
    VisualEditorState state,
    VisualEditorController notifier,
  ) {
    final List<Widget> sections = [];
    int sectionIndex = 4;

    if (state.selectedOutput == OutputType.websiteKatalog) {
      sections.addAll(
        VisualEditorWebsiteSections.build(
          context,
          params: WebsiteSectionsParams(
            getNextSectionIndex: () => sectionIndex++,
            outputType: state.selectedOutput,
            selectedModel: state.selectedModel,
            selectedPhotoStyle: state.selectedPhotoStyle,
            selectedGender: state.selectedGender,
            selectedShootingAngles: state.selectedShootingAngles,
            onPhotoStyleSelected: (v) => notifier.updateSelectedPhotoStyle(v),
            onGenderSelected: (v) => notifier.updateSelectedGender(v),
            onShootingAngleTap: (angle) => notifier.toggleShootingAngle(angle),
            buildClearButton: (theme, scheme, isDark, onTap) =>
                VisualEditorShared.buildClearButton(
                  theme,
                  scheme,
                  isDark,
                  onTap,
                ),
            buildMankenCard: (ctx) => _buildMankenCard(
              ctx,
              state: state,
              notifier: notifier,
              gradient: _gradient(state),
              accent: _shadowColor(state),
            ),
          ),
        ),
      );
    }

    if (state.selectedOutput == OutputType.editorialStudio) {
      sections.addAll(
        VisualEditorEditorialSections.build(
          context,
          params: EditorialSectionsParams(
            getNextSectionIndex: () => sectionIndex++,
            outputType: state.selectedOutput,
            selectedModel: state.selectedModel,
            selectedEditorialAngle: state.selectedEditorialAngle,
            selectedObject: state.selectedObject,
            selectedEditorialObjects: state.selectedEditorialObjects,
            editorialObjectCustomTextController:
                _editorialObjectCustomTextController,
            editorialObjectCategories:
                VisualEditorConstants.editorialObjectCategories,
            selectedBackground: state.selectedBackground,
            customBackgroundColor: state.customBackgroundColor,
            kendinBelirleBackgroundMode: state.kendinBelirleBackgroundMode,
            backgroundDescriptionController: _backgroundDescriptionController,
            selectedEditorialGender: state.selectedEditorialGender,
            selectedEditorialFraming: state.selectedEditorialFraming,
            onEditorialAngleSelected: (v) =>
                notifier.updateSelectedEditorialAngle(v),
            onObjectModeObjeSec: () {
              notifier.setObjectModeObjeSec();
              _editorialObjectCustomTextController.clear();
            },
            onObjectModeKendinBelirle: () =>
                notifier.setObjectModeKendinBelirle(),
            onObjectToggle: (option) =>
                notifier.toggleEditorialObject(option, maxSelection: 2),
            onObjectCustomChanged: (_) {},
            onObjectClear: () {
              notifier.clearEditorialObjectSelection();
              _editorialObjectCustomTextController.clear();
            },
            onBackgroundSelected: (v) {
              notifier.updateSelectedBackground(v);
              if (v == 'Gri' || v == 'Beyaz') {
                _backgroundDescriptionController.clear();
              }
            },
            onBackgroundClear: () {
              notifier.clearBackground();
              _backgroundDescriptionController.clear();
            },
            onKendinBelirleModeKendinBelirle: () =>
                notifier.updateKendinBelirleBackgroundMode('Kendin Belirle'),
            onKendinBelirleModeTRYPIX: () =>
                notifier.updateKendinBelirleBackgroundMode('TRYPIX Belirlesin'),
            onBackgroundDescriptionChanged: () {},
            onEditorialGenderSelected: (v) =>
                notifier.updateSelectedEditorialGender(v),
            onEditorialFramingSelected: (v) =>
                notifier.updateSelectedEditorialFraming(v),
            colorToHex: VisualEditorShared.colorToHex,
            buildClearButton: (theme, scheme, isDark, onTap) =>
                VisualEditorShared.buildClearButton(
                  theme,
                  scheme,
                  isDark,
                  onTap,
                ),
            buildMankenCard: (ctx) => _buildMankenCard(
              ctx,
              state: state,
              notifier: notifier,
              gradient: _gradient(state),
              accent: _shadowColor(state),
            ),
          ),
        ),
      );
    }

    if (state.selectedOutput == OutputType.disMekan) {
      sections.addAll(
        VisualEditorOutdoorSections.build(
          context,
          params: OutdoorSectionsParams(
            getNextSectionIndex: () => sectionIndex++,
            outputType: state.selectedOutput,
            selectedModel: state.selectedModel,
            selectedOutdoorGender: state.selectedOutdoorGender,
            selectedShootingFrames: state.selectedShootingFrames,
            selectedTimeOfDay: state.selectedTimeOfDay,
            selectedLocation: state.selectedLocation,
            selectedLocationSuggestion: state.selectedLocationSuggestion,
            locationCustomTextController: _outdoorLocationCustomTextController,
            locationCategories: VisualEditorConstants.outdoorLocationCategories,
            selectedOutdoorObject: state.selectedOutdoorObject,
            selectedOutdoorObjects: state.selectedOutdoorObjects,
            objectCustomTextController: _outdoorObjectCustomTextController,
            objectCategories: VisualEditorConstants.editorialObjectCategories,
            onOutdoorGenderSelected: (v) =>
                notifier.updateSelectedOutdoorGender(v),
            onShootingFrameTap: (frame) => notifier.toggleShootingFrame(frame),
            onTimeOfDaySelected: (v) => notifier.updateSelectedTimeOfDay(v),
            onLocationModeMekanSec: () {
              notifier.setLocationModeMekanSec();
              _outdoorLocationCustomTextController.clear();
            },
            onLocationModeKendinBelirle: () =>
                notifier.setLocationModeKendinBelirle(),
            onLocationSuggestionSelected: (loc) =>
                notifier.updateSelectedLocationSuggestion(loc),
            onLocationCustomChanged: (value) =>
                notifier.updateOutdoorLocationCustomText(value),
            onLocationClear: () {
              notifier.clearLocationSelection();
              _outdoorLocationCustomTextController.clear();
            },
            onOutdoorObjectModeObjeSec: () {
              notifier.setOutdoorObjectModeObjeSec();
              _outdoorObjectCustomTextController.clear();
            },
            onOutdoorObjectModeKendinBelirle: () =>
                notifier.setOutdoorObjectModeKendinBelirle(),
            onOutdoorObjectToggle: (option) =>
                notifier.toggleOutdoorObject(option, maxSelection: 2),
            onOutdoorObjectCustomChanged: (_) {},
            onOutdoorObjectClear: () {
              notifier.clearOutdoorObjectSelection();
              _outdoorObjectCustomTextController.clear();
            },
            buildClearButton: (theme, scheme, isDark, onTap) =>
                VisualEditorShared.buildClearButton(
                  theme,
                  scheme,
                  isDark,
                  onTap,
                ),
            buildMankenCard: (ctx) => _buildMankenCard(
              ctx,
              state: state,
              notifier: notifier,
              gradient: _gradient(state),
              accent: _shadowColor(state),
            ),
          ),
        ),
      );
    }

    // Background selector (conditional) — Dış Mekan'da arka plan seçeneği yok
    final shouldShowBackground =
        state.selectedOutput != OutputType.disMekan &&
        !(state.selectedOutput == OutputType.editorialStudio &&
            state.selectedModel == 'Mankensiz');

    if (shouldShowBackground) {
      String backgroundTitle = '7) Arka Plan';
      if (state.selectedOutput == OutputType.disMekan) {
        backgroundTitle = '9) Arka Plan';
      } else if (state.selectedOutput == OutputType.editorialStudio &&
          state.selectedModel == 'Mankenli') {
        backgroundTitle = '8) Arka Plan';
      } else if (state.selectedOutput == OutputType.editorialStudio) {
        backgroundTitle = '7) Arka Plan';
      }

      sections.addAll([
        VisualEditorSection(
          index: sectionIndex++,
          title: backgroundTitle,
          subtitle: 'Arka plan rengini özelleştir',
          icon: Icons.format_color_fill_rounded,
          outputType: state.selectedOutput,
          child: VisualEditorShared.buildBackgroundSection(
            context,
            outputType: state.selectedOutput,
            selectedBackground: state.selectedBackground,
            customBackgroundColor: state.customBackgroundColor,
            kendinBelirleBackgroundMode: state.kendinBelirleBackgroundMode,
            backgroundDescriptionController: _backgroundDescriptionController,
            onBackgroundClear: () {
              notifier.clearBackground();
              _backgroundDescriptionController.clear();
            },
            onBackgroundGriTap: () {
              notifier.updateSelectedBackground('Gri');
              _backgroundDescriptionController.clear();
            },
            onBackgroundBeyazTap: () {
              notifier.updateSelectedBackground('Beyaz');
              _backgroundDescriptionController.clear();
            },
            onBackgroundKendinBelirleTap: () =>
                notifier.updateSelectedBackground('Kendin Belirle'),
            onKendinBelirleModeKendinBelirle: () =>
                notifier.updateKendinBelirleBackgroundMode('Kendin Belirle'),
            onKendinBelirleModeTRYPIX: () =>
                notifier.updateKendinBelirleBackgroundMode('TRYPIX Belirlesin'),
            onBackgroundDescriptionChanged: () {},
            colorToHex: VisualEditorShared.colorToHex,
            buildClearButton: VisualEditorShared.buildClearButton,
          ),
        ),
        const SizedBox(height: 36),
      ]);
    }

    return sections;
  }

  // ========== MODAL & UTILITY METHODS ==========

  Future<void> _pickImage(String label) async {
    final notifier = ref.read(visualEditorControllerProvider.notifier);
    final state = ref.read(visualEditorControllerProvider);
    try {
      notifier.setUploading(true);

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
        maxWidth: 2048,
        maxHeight: 2048,
      );

      if (image != null) {
        await Future.delayed(const Duration(milliseconds: 1500));

        notifier.setUploadedImage(label, File(image.path));
        notifier.setUploading(false);

        ref
            .read(selectedImagesControllerProvider.notifier)
            .addImage(label, image.path);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      '$label fotoğrafı başarıyla yüklendi',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: _shadowColor(state),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } else {
        notifier.setUploading(false);
      }
    } catch (e) {
      notifier.setUploading(false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_rounded, color: Colors.white, size: 22),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Fotoğraf yüklenirken hata oluştu',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        );
      }
    }
  }
}
