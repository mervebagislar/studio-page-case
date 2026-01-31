import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/background_editor/background_editor_utils.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/background_editor/background_editor_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/background_editor/background_editor_header.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/background_editor/background_editor_image_upload_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/background_editor/background_editor_color_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/background_editor/background_editor_pose_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/background_editor/background_editor_info_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/background_editor/background_editor_action_bar.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/image_upload_modal.dart';
import 'package:studio_page_case/features/studio/state/generation/generation_type.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_controller.dart';
import 'package:studio_page_case/features/studio/state/selection/selected_images_controller.dart';

class BackgroundEditorView extends ConsumerStatefulWidget {
  const BackgroundEditorView({super.key});

  @override
  ConsumerState<BackgroundEditorView> createState() =>
      _BackgroundEditorViewState();
}

class _BackgroundEditorViewState extends ConsumerState<BackgroundEditorView>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  String? _selectedBackgroundColor;
  Color _customColor = const Color(0xFFFF6B6B);
  bool _poseCorrectionEnabled = false;
  final ImagePicker _imagePicker = ImagePicker();
  late AnimationController _pulseController;
  late AnimationController _shimmerController;
  late AnimationController _headerController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            scheme.surface,
            isDark 
              ? const Color(0xFF0F2830).withValues(alpha: 0.3)
              : const Color(0xFFF0FDFA),
          ],
        ),
      ),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: BackgroundEditorHeader(
              theme: theme,
              scheme: scheme,
              isDark: isDark,
              headerController: _headerController,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                BackgroundEditorSection(
                  title: '1) Görsel Yükle',
                  subtitle: 'Arka planı değiştirilecek fotoğraf',
                  icon: Icons.wallpaper_rounded,
                  child: BackgroundEditorImageUploadSection(
                    theme: theme,
                    scheme: scheme,
                    isDark: isDark,
                    imagePath: ref.watch(selectedImagesControllerProvider).imagePaths['Arka Plan'],
                    shimmerAnimation: _shimmerController,
                    onUploadTap: () => _showBackgroundImageUploadModal(context),
                    onRemoveTap: () {
                      ref.read(selectedImagesControllerProvider.notifier).removeImage('Arka Plan');
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 32),

                BackgroundEditorSection(
                  title: '2) Arka Plan Rengi',
                  subtitle: 'Yeni arka plan rengini seçin',
                  icon: Icons.palette_rounded,
                  child: BackgroundEditorColorSection(
                    theme: theme,
                    scheme: scheme,
                    isDark: isDark,
                    selectedBackgroundColor: _selectedBackgroundColor,
                    customColor: _customColor,
                    onColorSelected: (label) =>
                        setState(() => _selectedBackgroundColor = label),
                    onCustomColorPicked: (color) => setState(() {
                          _customColor = color;
                          _selectedBackgroundColor = 'Özel Renk';
                        }),
                  ),
                ),
                const SizedBox(height: 32),

                BackgroundEditorSection(
                  title: '3) Ek Özellikler',
                  subtitle: 'İsteğe bağlı düzenleme seçenekleri',
                  icon: Icons.tune_rounded,
                  child: BackgroundEditorPoseSection(
                    theme: theme,
                    scheme: scheme,
                    isDark: isDark,
                    poseCorrectionEnabled: _poseCorrectionEnabled,
                    onChanged: (v) => setState(() => _poseCorrectionEnabled = v),
                  ),
                ),
                const SizedBox(height: 32),

                BackgroundEditorInfoSection(
                  theme: theme,
                  scheme: scheme,
                  isDark: isDark,
                ),
                const SizedBox(height: 40),

                BackgroundEditorActionBar(
                  theme: theme,
                  scheme: scheme,
                  isDark: isDark,
                  isEnabled: _selectedBackgroundColor != null,
                  onGenerateTap: () {
                    HapticFeedback.lightImpact();
                    final currentConfig =
                        ref.read(studioControllerProvider).config;
                    ref
                        .read(studioControllerProvider.notifier)
                        .updateConfig(currentConfig.copyWith(count: 1));
                    ref
                        .read(studioControllerProvider.notifier)
                        .generate(type: GenerationType.visual.value);
                  },
                ),
                const SizedBox(height: 120),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _showBackgroundImageUploadModal(BuildContext context) {
    ImageUploadModal.show(
      context,
      title: 'Görsel Yükle',
      subtitle: 'Arka planı değiştirilecek fotoğrafı seçin',
      gradient: BackgroundEditorUtils.headerGradient,
      shadowColor: const Color(0xFFFF5C9D),
      onUploadTap: () {
        Navigator.of(context).pop();
        _pickBackgroundImage();
      },
      uploadButtonLabel: 'Fotoğraf Yükle',
      formatHint: 'PNG, JPG (maks. 10 MB)',
    );
  }

  Future<void> _pickBackgroundImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 2048,
        imageQuality: 90,
      );
      if (image != null && mounted) {
        ref
            .read(selectedImagesControllerProvider.notifier)
            .addImage('Arka Plan', image.path);
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fotoğraf seçilemedi: $e')),
        );
      }
    }
  }

}