import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/video_editor/video_editor_header.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/video_editor/video_editor_image_upload_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/video_editor/video_editor_prompt_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/video_editor/video_editor_quality_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/video_editor/video_editor_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/video_editor/video_editor_generate_button.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/video_editor/video_editor_tips_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/video_editor/video_editor_utils.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/image_upload_modal.dart';
import 'package:studio_page_case/features/studio/state/generation/generation_type.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_controller.dart';
import 'package:studio_page_case/features/studio/state/selection/selected_images_controller.dart';

class VideoEditorView extends ConsumerStatefulWidget {
  const VideoEditorView({super.key});

  @override
  ConsumerState<VideoEditorView> createState() => _VideoEditorViewState();
}

class _VideoEditorViewState extends ConsumerState<VideoEditorView>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  String _selectedVideoQuality = 'Basic Video';
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
                ? const Color(0xFF0F172A).withValues(alpha: 0.3)
                : const Color(0xFFF8FAFC),
          ],
        ),
      ),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: VideoEditorHeader(
              theme: theme,
              scheme: scheme,
              headerController: _headerController,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                VideoEditorSection(
                  title: '1) Başlangıç Sahnesi',
                  subtitle: 'Video için ilk kareyi yükleyin',
                  icon: Icons.photo_camera_rounded,
                  child: VideoEditorImageUploadSection(
                    videoFramePath: ref
                        .watch(selectedImagesControllerProvider)
                        .imagePaths['Video'],
                    shimmerController: _shimmerController,
                    theme: theme,
                    scheme: scheme,
                    isDark: isDark,
                    onUploadTap: () => _showVideoImageUploadModal(context),
                    onChangeTap: () => _showVideoImageUploadModal(context),
                    onRemoveTap: () {
                      ref
                          .read(
                            selectedImagesControllerProvider.notifier,
                          )
                          .removeImage('Video');
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 32),

                VideoEditorSection(
                  title: '2) Video Kalitesi',
                  subtitle: 'İhtiyacınıza uygun kaliteyi seçin',
                  icon: Icons.high_quality_rounded,
                  child: VideoEditorQualitySection(
                    selectedQuality: _selectedVideoQuality,
                    onQualitySelected: (q) => setState(() => _selectedVideoQuality = q),
                    theme: theme,
                    scheme: scheme,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(height: 32),

                VideoEditorSection(
                  title: '3) Video Açıklaması',
                  subtitle: 'Videoda ne olmasını istediğinizi detaylı anlatın',
                  icon: Icons.auto_awesome_rounded,
                  child: VideoEditorPromptSection(
                    controller: _promptController,
                    theme: theme,
                    scheme: scheme,
                    isDark: isDark,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(height: 32),

                VideoEditorTipsSection(
                  theme: theme,
                  scheme: scheme,
                  isDark: isDark,
                ),
                const SizedBox(height: 40),

                VideoEditorGenerateButton(
                  isEnabled: _promptController.text.isNotEmpty,
                  credits: _selectedVideoCredits,
                  onGenerate: () {
                    final currentConfig = ref
                        .read(studioControllerProvider)
                        .config;
                    HapticFeedback.lightImpact();
                    ref
                        .read(studioControllerProvider.notifier)
                        .updateConfig(currentConfig.copyWith(count: 1));
                    ref
                        .read(studioControllerProvider.notifier)
                        .generate(type: GenerationType.video.value);
                  },
                  theme: theme,
                  scheme: scheme,
                ),
                const SizedBox(height: 120),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _showVideoImageUploadModal(BuildContext context) {
    ImageUploadModal.show(
      context,
      title: 'Başlangıç Sahnesi',
      subtitle: 'Video için ilk kareyi yükleyin',
      gradient: VideoEditorUtils.modernGradient,
      shadowColor: VideoEditorUtils.shadowColor,
      onUploadTap: () {
        Navigator.of(context).pop();
        _pickVideoImage();
      },
      uploadButtonLabel: 'Görsel Yükle',
      formatHint: 'JPEG, PNG (maks. 25 MB)',
    );
  }

  Future<void> _pickVideoImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 2048,
        imageQuality: 90,
      );
      if (image != null && mounted) {
        ref
            .read(selectedImagesControllerProvider.notifier)
            .addImage('Video', image.path);
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Görsel seçilemedi: $e')));
      }
    }
  }

  int get _selectedVideoCredits {
    switch (_selectedVideoQuality) {
      case 'Pro Video':
        return 200;
      case 'Basic Video':
      default:
        return 120;
    }
  }
}
