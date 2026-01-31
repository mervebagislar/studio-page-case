import 'dart:io';
import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_image_upload_area.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';

/// Ürün fotoğrafı yükleme alanı: outputType'a göre Website (3 kart), Editorial veya Outdoor tek alan.
/// Sadece UI + onUploadTap; state parent'ta kalır. Modal açma ve callback'ler aynen korunur.
class VisualEditorImageUploadSection extends StatelessWidget {
  final OutputType outputType;
  final Map<String, File?> uploadedImages;
  final ValueChanged<String> onUploadTap;
  final Animation<double> shimmerAnimation;

  const VisualEditorImageUploadSection({
    super.key,
    required this.outputType,
    required this.uploadedImages,
    required this.onUploadTap,
    required this.shimmerAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final shadowColor = VisualEditorUtils.getShadowColor(outputType);

    if (outputType == OutputType.websiteKatalog) {
      final slots = [
        EditorImageUploadSlot(label: 'Önden', file: uploadedImages['Önden']),
        EditorImageUploadSlot(label: 'Yandan', file: uploadedImages['Yandan']),
        EditorImageUploadSlot(label: 'Arkadan', file: uploadedImages['Arkadan']),
      ];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EditorImageUploadArea(
            slots: slots,
            onSlotTap: (i) => onUploadTap(slots[i].label),
            shimmerAnimation: shimmerAnimation,
            accentColor: shadowColor,
            cardHeight: 170,
            isSingleLayout: false,
            placeholderSubtitle: 'Tıklayarak yükle',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  scheme.primaryContainer.withValues(alpha: 0.4),
                  scheme.primaryContainer.withValues(alpha: 0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: scheme.primary.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded, size: 22, color: scheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Bir veya daha fazla açıdan fotoğraf yükleyebilirsiniz. En az bir fotoğraf yeterlidir.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    if (outputType == OutputType.editorialStudio) {
      final slots = [
        EditorImageUploadSlot(label: 'Editorial', file: uploadedImages['Editorial']),
      ];
      return EditorImageUploadArea(
        slots: slots,
        onSlotTap: (_) => onUploadTap('Editorial'),
        shimmerAnimation: shimmerAnimation,
        accentColor: shadowColor,
        cardHeight: 220,
        isSingleLayout: true,
        placeholderTitle: 'Ürün fotoğrafı yükle',
        placeholderSubtitle: 'Tıklayarak görsel seç',
        filledBadgeText: 'Ürün fotoğrafı yüklendi',
        singleEmptyBackgroundColor: theme.brightness == Brightness.dark
            ? const Color(0xFF0F2830).withValues(alpha: 0.5)
            : null,
      );
    }

    final slots = [
      EditorImageUploadSlot(label: 'Outdoor', file: uploadedImages['Outdoor']),
    ];
    return EditorImageUploadArea(
      slots: slots,
      onSlotTap: (_) => onUploadTap('Outdoor'),
      shimmerAnimation: shimmerAnimation,
      accentColor: shadowColor,
      cardHeight: 220,
      isSingleLayout: true,
      placeholderTitle: 'Ürün fotoğrafı yükle',
      placeholderSubtitle: 'Tıklayarak görsel seç',
      filledBadgeText: 'Ürün fotoğrafı yüklendi',
      singleEmptyBackgroundColor: theme.brightness == Brightness.dark
          ? const Color(0xFF0F2830).withValues(alpha: 0.5)
          : null,
    );
  }
}
