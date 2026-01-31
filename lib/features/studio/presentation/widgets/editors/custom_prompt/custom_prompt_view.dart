import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/custom_prompt/custom_prompt_utils.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/custom_prompt/custom_prompt_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/custom_prompt/custom_prompt_header.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/custom_prompt/custom_prompt_image_upload_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_aspect_ratio_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart' show OutputType;
import 'package:studio_page_case/features/studio/presentation/widgets/editors/custom_prompt/custom_prompt_field_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/custom_prompt/custom_prompt_info_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/custom_prompt/custom_prompt_action_bar.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/image_upload_modal.dart';
import 'package:studio_page_case/features/studio/state/generation/generation_type.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_controller.dart';
import 'package:studio_page_case/features/studio/state/selection/selected_images_controller.dart';

class CustomPromptView extends ConsumerStatefulWidget {
  const CustomPromptView({super.key});

  @override
  ConsumerState<CustomPromptView> createState() => _CustomPromptViewState();
}

class _CustomPromptViewState extends ConsumerState<CustomPromptView>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  String? _selectedAspectRatio;
  final TextEditingController _promptController = TextEditingController();
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
    _promptController.dispose();
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
                ? const Color(0xFF1E1B4B).withValues(alpha: 0.2)
                : const Color(0xFFFAF5FF),
          ],
        ),
      ),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: CustomPromptHeader(
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
                CustomPromptSection(
                  title: '1) Ürün Görselini Yükle',
                  subtitle: 'Ürün fotoğrafı yükle',
                  icon: Icons.add_photo_alternate_rounded,
                  child: CustomPromptImageUploadSection(
                    theme: theme,
                    scheme: scheme,
                    isDark: isDark,
                    imagePath: ref.watch(selectedImagesControllerProvider).imagePaths['Özel'],
                    shimmerAnimation: _shimmerController,
                    onUploadTap: () => _showCustomPromptUploadModal(context),
                    onRemoveTap: () {
                      ref.read(selectedImagesControllerProvider.notifier).removeImage('Özel');
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 32),

                CustomPromptSection(
                  title: '2) En/Boy Oranı',
                  subtitle: 'Çıktı görsel boyutunu seçin',
                  icon: Icons.aspect_ratio_rounded,
                  child: EditorAspectRatioSection(
                    selectedAspectRatio: _selectedAspectRatio,
                    onAspectRatioSelected: (ratio) =>
                        setState(() => _selectedAspectRatio = ratio),
                    outputType: OutputType.editorialStudio,
                  ),
                ),
                const SizedBox(height: 32),

                CustomPromptSection(
                  title: '3) Prompt \'unuzu Yazın',
                  subtitle: 'İstediğiniz görseli detaylı açıklayın',
                  icon: Icons.auto_awesome_rounded,
                  child: CustomPromptFieldSection(
                    theme: theme,
                    scheme: scheme,
                    isDark: isDark,
                    controller: _promptController,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(height: 32),

                CustomPromptInfoSection(
                  theme: theme,
                  scheme: scheme,
                  isDark: isDark,
                ),
                const SizedBox(height: 40),

                CustomPromptActionBar(
                  theme: theme,
                  scheme: scheme,
                  isDark: isDark,
                  isEnabled: _promptController.text.isNotEmpty && _selectedAspectRatio != null,
                  onGenerateTap: () {
                    HapticFeedback.lightImpact();
                    final currentConfig =
                        ref.read(studioControllerProvider).config;
                    ref
                        .read(studioControllerProvider.notifier)
                        .updateConfig(currentConfig.copyWith(count: 4));
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

  void _showCustomPromptUploadModal(BuildContext context) {
    ImageUploadModal.show(
      context,
      title: '1) Ürün Görselini Yükle',
      subtitle: 'Ürün fotoğrafı yükle',
      gradient: CustomPromptUtils.modernPurpleGradient,
      shadowColor: const Color(0xFF9333EA),
      onUploadTap: () {
        Navigator.of(context).pop();
        _pickCustomPromptImage();
      },
      uploadButtonLabel: 'Tıklayarak görsel seç',
      formatHint: 'PNG, JPG (max. 10MB)',
    );
  }

  Future<void> _pickCustomPromptImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 2048,
        imageQuality: 90,
      );
      if (image != null && mounted) {
        ref
            .read(selectedImagesControllerProvider.notifier)
            .addImage('Özel', image.path);
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Görsel seçilemedi: $e')),
        );
      }
    }
  }
}
