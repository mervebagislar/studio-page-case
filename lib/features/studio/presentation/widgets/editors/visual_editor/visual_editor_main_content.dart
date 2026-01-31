import 'dart:io';
import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_configuration_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_image_upload_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_output_type_selector.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_preview_card.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';

/// Sadece UI kompozisyonu: ana scroll içeriği (çıktı seçimi, manken, yükleme, oran, koşullu bölümler, action bar).
/// State veya controller oluşturmaz; tüm değerler ve callback'ler constructor'dan gelir.
class VisualEditorMainContent extends StatelessWidget {
  const VisualEditorMainContent({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.selectedOutput,
    required this.onOutputTypeSelected,
    required this.selectedAspectRatio,
    required this.onAspectRatioSelected,
    required this.selectedModel,
    required this.onModelSelected,
    required this.previewImagePath,
    required this.modelLabel,
    required this.shadowColor,
    required this.gradient,
    required this.hideProductPhotoSection,
    required this.uploadedImages,
    required this.isUploading,
    required this.shimmerController,
    required this.onUploadTap,
    required this.conditionalSections,
    required this.createActionBar,
    this.hasUploadedImages = false,
    this.buildClearUploadButton,
    this.onClearUpload,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  final OutputType selectedOutput;
  final ValueChanged<OutputType> onOutputTypeSelected;
  final String? selectedAspectRatio;
  final ValueChanged<String?> onAspectRatioSelected;
  final String? selectedModel;
  final ValueChanged<String?> onModelSelected;
  final String previewImagePath;
  final String modelLabel;
  final Color shadowColor;
  final LinearGradient gradient;
  final bool hideProductPhotoSection;
  final Map<String, File?> uploadedImages;
  final bool isUploading;
  final AnimationController shimmerController;
  final void Function(String label) onUploadTap;
  final List<Widget> conditionalSections;
  final Widget createActionBar;
  final bool hasUploadedImages;
  final Widget Function(ThemeData theme, ColorScheme scheme, bool isDark, VoidCallback onTap)? buildClearUploadButton;
  final VoidCallback? onClearUpload;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          VisualEditorSection(
            index: 0,
            title: '1) İhtiyacın olan çıktıyı seç',
            subtitle: 'Oluşturmak istediğin görsel türünü belirle',
            icon: Icons.category_rounded,
            outputType: selectedOutput,
            child: VisualEditorOutputTypeSelector(
              selectedType: selectedOutput,
              onTypeSelected: onOutputTypeSelected,
            ),
          ),
          const SizedBox(height: 36),

          VisualEditorSection(
            index: 1,
            title: '2) Bir seçim yap',
            subtitle: 'Mankenli veya mankensiz görsel oluştur',
            icon: Icons.person_outline_rounded,
            outputType: selectedOutput,
            child: VisualEditorConfigurationSection(
              selectedAspectRatio: selectedAspectRatio,
              onAspectRatioSelected: (_) {},
              selectedModel: selectedModel,
              onModelSelected: onModelSelected,
              outputType: selectedOutput,
              showModelSelector: true,
              showAspectRatioSelector: false,
            ),
          ),
          const SizedBox(height: 16),
          VisualEditorPreviewCard(
            theme: theme,
            scheme: scheme,
            isDark: isDark,
            previewImagePath: previewImagePath,
            modelLabel: modelLabel,
            shadowColor: shadowColor,
            gradient: gradient,
          ),
          const SizedBox(height: 36),

          if (!hideProductPhotoSection) ...[
            VisualEditorSection(
              index: 2,
              title: '3) Ürün fotoğrafı yükle',
              subtitle: 'Yüksek kaliteli ürün görseli seç',
              icon: Icons.cloud_upload_rounded,
              outputType: selectedOutput,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasUploadedImages &&
                      buildClearUploadButton != null &&
                      onClearUpload != null) ...[
                    buildClearUploadButton!(
                      theme,
                      scheme,
                      isDark,
                      onClearUpload!,
                    ),
                    const SizedBox(height: 14),
                  ],
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      VisualEditorImageUploadSection(
                        outputType: selectedOutput,
                        uploadedImages: uploadedImages,
                        shimmerAnimation: shimmerController,
                        onUploadTap: onUploadTap,
                      ),
                      if (isUploading)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface.withValues(
                                alpha: 0.85,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        theme.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Fotoğraf yükleniyor...',
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
          ],

          VisualEditorSection(
            index: 3,
            title: '4) En/Boy Oranı',
            subtitle: 'Görsel çıktı boyutunu ayarla',
            icon: Icons.aspect_ratio_rounded,
            outputType: selectedOutput,
            child: VisualEditorConfigurationSection(
              selectedAspectRatio: selectedAspectRatio,
              onAspectRatioSelected: onAspectRatioSelected,
              selectedModel: selectedModel,
              onModelSelected: (_) {},
              outputType: selectedOutput,
              showModelSelector: false,
              showAspectRatioSelector: true,
            ),
          ),
          const SizedBox(height: 36),

          ...conditionalSections,

          const SizedBox(height: 1),

          createActionBar,

          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
