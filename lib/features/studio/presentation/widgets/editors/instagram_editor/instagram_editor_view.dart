import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_utils.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_header.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_image_upload_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_configuration_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_gender_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/manken_modal_data.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_manken_card.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_location_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_time_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_angle_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_preview_card.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_action_bar.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/image_upload_modal.dart';
import 'package:studio_page_case/features/studio/state/generation/generation_type.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_controller.dart';
import 'package:studio_page_case/features/studio/state/selection/selected_images_controller.dart';

class InstagramEditorView extends ConsumerStatefulWidget {
  const InstagramEditorView({super.key});

  @override
  ConsumerState<InstagramEditorView> createState() =>
      _InstagramEditorViewState();
}

class _InstagramEditorViewState extends ConsumerState<InstagramEditorView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  String? _selectedAspectRatio;
  int? _selectedImageCount;
  String? _selectedGender;
  String? _locationMode;
  String? _selectedLocationSuggestion;
  final TextEditingController _locationCustomTextController = TextEditingController();
  String? _selectedTimeOfDay;
  String? _selectedShootingAngle;

  String? _modelBodyType;
  String? _modelEthnicity;
  String? _modelSkinTone;
  String? _modelHairColor;
  String? _modelHairLength;
  String? _modelAgeGroup;

  final ImagePicker _imagePicker = ImagePicker();

  late AnimationController _headerController;
  late AnimationController _shimmerController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _locationCustomTextController.dispose();
    _headerController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 3),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      scheme.surface,
                      scheme.surface.withValues(alpha: 0.95),
                      scheme.surfaceContainerHighest.withValues(alpha: 0.3),
                    ]
                  : [
                      scheme.surface,
                      scheme.primaryContainer.withValues(alpha: 0.03),
                      scheme.secondaryContainer.withValues(alpha: 0.05),
                    ],
            ),
          ),
        ),
        CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InstagramEditorHeader(
                    theme: theme,
                    scheme: scheme,
                    isDark: isDark,
                    headerController: _headerController,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    child: InstagramEditorPreviewCard(
                      theme: theme,
                      scheme: scheme,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  InstagramEditorSection(
                    title: '1) Ürün Fotoğrafı',
                    subtitle: 'Modellenecek ürünü yükleyin',
                    icon: Icons.collections_rounded,
                    child: Consumer(
                      builder: (context, ref, _) {
                        final imagePath = ref.watch(
                          selectedImagesControllerProvider.select(
                            (s) => s.imagePaths['Ürün'],
                          ),
                        );
                        return InstagramEditorImageUploadSection(
                          theme: theme,
                          scheme: scheme,
                          isDark: isDark,
                          imagePath: imagePath,
                          shimmerAnimation: _shimmerController,
                          onUploadTap: () => _showInstagramUploadModal(context, theme, scheme, isDark),
                          onRemoveTap: () {
                            ref.read(selectedImagesControllerProvider.notifier).removeImage('Ürün');
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),

                  InstagramEditorSection(
                    title: '2)  En/Boy Oranı',
                    subtitle: 'Görsel boyutunu seçin',
                    icon: Icons.aspect_ratio_rounded,
                    child: InstagramEditorConfigurationSection(
                      selectedAspectRatio: _selectedAspectRatio,
                      onAspectRatioSelected: (v) =>
                          setState(() => _selectedAspectRatio = v),
                      selectedImageCount: _selectedImageCount,
                      onImageCountSelected: (v) =>
                          setState(() => _selectedImageCount = v),
                      showAspectRatioSelector: true,
                      showImageCountSelector: false,
                    ),
                  ),
                  const SizedBox(height: 32),

                  InstagramEditorSection(
                    title: '3) Görsel Sayısı',
                    subtitle: 'Kaç adet görsel oluşturulsun',
                    icon: Icons.image_rounded,
                    child: InstagramEditorConfigurationSection(
                      selectedAspectRatio: _selectedAspectRatio,
                      onAspectRatioSelected: (v) =>
                          setState(() => _selectedAspectRatio = v),
                      selectedImageCount: _selectedImageCount,
                      onImageCountSelected: (v) =>
                          setState(() => _selectedImageCount = v),
                      showAspectRatioSelector: false,
                      showImageCountSelector: true,
                    ),
                  ),
                  const SizedBox(height: 32),

                  InstagramEditorSection(
                    title: '4) Manken Özelliklerini Seç',
                    subtitle: 'Manken özelliklerini belirleyin',
                    icon: Icons.person_outline_rounded,
                    child: InstagramEditorGenderSection(
                      theme: theme,
                      scheme: scheme,
                      isDark: isDark,
                      selectedGender: _selectedGender,
                      onGenderSelected: (v) => setState(() => _selectedGender = v),
                      mankenCard: EditorMankenCard(
                        theme: theme,
                        scheme: scheme,
                        isDark: isDark,
                        initialData: MankenModalData(
                          bodyType: _modelBodyType,
                          ethnicity: _modelEthnicity,
                          skinTone: _modelSkinTone,
                          hairColor: _modelHairColor,
                          hairLength: _modelHairLength,
                          ageGroup: _modelAgeGroup,
                        ),
                        gradient: InstagramEditorUtils.instagramGradient,
                        accent: InstagramEditorUtils.instagramAccent,
                        onSave: (data) => setState(() {
                          _modelBodyType = data.bodyType;
                          _modelEthnicity = data.ethnicity;
                          _modelSkinTone = data.skinTone;
                          _modelHairColor = data.hairColor;
                          _modelHairLength = data.hairLength;
                          _modelAgeGroup = data.ageGroup;
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  InstagramEditorSection(
                    title: '5) Mekan Seçimi',
                    subtitle: 'Fotoğraf çekileceği ortam',
                    icon: Icons.location_on_outlined,
                    child: InstagramEditorLocationSection(
                      selectedLocation: _locationMode,
                      selectedLocationSuggestion: _selectedLocationSuggestion,
                      locationCustomTextController: _locationCustomTextController,
                      onLocationModeMekanSec: () => setState(() {
                        _locationMode = 'Mekan Seç';
                        _selectedLocationSuggestion = null;
                        _locationCustomTextController.clear();
                      }),
                      onLocationModeKendinBelirle: () => setState(() {
                        _locationMode = 'Kendin Belirle';
                        _selectedLocationSuggestion = null;
                      }),
                      onLocationSuggestionSelected: (v) => setState(() => _selectedLocationSuggestion = v),
                      onLocationCustomChanged: (_) => setState(() {}),
                      onLocationClear: () => setState(() {
                        _locationMode = null;
                        _selectedLocationSuggestion = null;
                        _locationCustomTextController.clear();
                      }),
                    ),
                  ),
                  const SizedBox(height: 32),

                  InstagramEditorSection(
                    title: '6) Günün Zamanı',
                    subtitle: 'Işık ve atmosfer tercihi',
                    icon: Icons.wb_sunny_outlined,
                    child: InstagramEditorTimeSection(
                      theme: theme,
                      scheme: scheme,
                      isDark: isDark,
                      selectedTimeOfDay: _selectedTimeOfDay,
                      onTimeOfDaySelected: (v) => setState(() => _selectedTimeOfDay = v),
                    ),
                  ),
                  const SizedBox(height: 32),

                  InstagramEditorSection(
                    title: '7) Çekim Açısı',
                    subtitle: 'Kamera perspektifi',
                    icon: Icons.camera_alt_outlined,
                    child: InstagramEditorAngleSection(
                      theme: theme,
                      scheme: scheme,
                      isDark: isDark,
                      selectedShootingAngle: _selectedShootingAngle,
                      onShootingAngleSelected: (v) => setState(() => _selectedShootingAngle = v),
                    ),
                  ),
                  const SizedBox(height: 40),

                  InstagramEditorActionBar(
                    canCreate: _isInstagramReady(),
                    subtitle: _selectedImageCount == 1
                        ? '40 Kredi  ·  1 Görsel'
                        : _selectedImageCount == 4
                            ? '150 Kredi  ·  4 Görsel'
                            : null,
                    onTap: _onInstagramGenerateTap,
                  ),
                  const SizedBox(height: 140),
                ]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showInstagramUploadModal(
    BuildContext context,
    ThemeData theme,
    ColorScheme scheme,
    bool isDark,
  ) {
    ImageUploadModal.show(
      context,
      title: 'Ürün Fotoğrafı',
      subtitle: 'Modellenecek ürünü yükleyin',
      gradient: InstagramEditorUtils.instagramGradient,
      shadowColor: InstagramEditorUtils.instagramAccent,
      onUploadTap: () {
        Navigator.of(context).pop();
        _pickInstagramImage();
      },
      uploadButtonLabel: 'Fotoğraf Yükle',
      formatHint: 'PNG, JPG (max. 10MB)',
    );
  }

  Future<void> _pickInstagramImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 2048,
        imageQuality: 90,
      );
      if (image != null && mounted) {
        ref
            .read(selectedImagesControllerProvider.notifier)
            .addImage('Ürün', image.path);
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Fotoğraf seçilemedi: $e')));
      }
    }
  }

  bool _isInstagramReady() {
    final imagePaths =
        ref.read(selectedImagesControllerProvider).imagePaths;
    final productPath = imagePaths['Ürün'];
    final locationOk = (_locationMode == 'Mekan Seç' && _selectedLocationSuggestion != null) ||
        (_locationMode == 'Kendin Belirle' && _locationCustomTextController.text.trim().isNotEmpty);
    return productPath != null &&
        productPath.isNotEmpty &&
        _selectedAspectRatio != null &&
        _selectedImageCount != null &&
        _selectedGender != null &&
        locationOk &&
        _selectedTimeOfDay != null &&
        _selectedShootingAngle != null;
  }

  void _onInstagramGenerateTap() {
    if (_isInstagramReady()) {
      final count = _selectedImageCount!;
      final currentConfig =
          ref.read(studioControllerProvider).config;
      HapticFeedback.lightImpact();
      ref.read(studioControllerProvider.notifier).updateConfig(
            currentConfig.copyWith(count: count),
          );
      ref
          .read(studioControllerProvider.notifier)
          .generate(type: GenerationType.visual.value);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Lütfen tüm alanları doldurun: ürün fotoğrafı, en/boy oranı, görsel sayısı, model, mekan, günün zamanı ve çekim açısı.',
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
