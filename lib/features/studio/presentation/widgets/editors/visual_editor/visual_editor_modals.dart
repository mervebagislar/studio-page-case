import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/image_upload_modal.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_controller.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';

/// Visual editor upload modals. Business logic stays in controller; UI only shows modal.
class VisualEditorModals {
  VisualEditorModals._();

  static void showEditorialUpload(
    BuildContext context,
    WidgetRef ref,
    void Function(String label) onPickImage,
  ) {
    final state = ref.read(visualEditorControllerProvider);
    final gradient = VisualEditorUtils.getSelectedGradient(state.selectedOutput);
    final shadowColor = VisualEditorUtils.getShadowColor(state.selectedOutput);
    ImageUploadModal.show(
      context,
      title: 'En İyi Sonuçlar İçin İpuçları',
      subtitle: 'Ürün fotoğrafı yükle',
      gradient: gradient,
      shadowColor: shadowColor,
      onUploadTap: () {
        Navigator.of(context).pop();
        onPickImage('Editorial');
      },
      uploadButtonLabel: 'Fotoğraf Yükle',
      formatHint: 'JPEG, PNG veya WEBP (maks. 25 MB)',
    );
  }

  static void showOutdoorUpload(
    BuildContext context,
    WidgetRef ref,
    void Function(String label) onPickImage,
  ) {
    final state = ref.read(visualEditorControllerProvider);
    final gradient = VisualEditorUtils.getSelectedGradient(state.selectedOutput);
    final shadowColor = VisualEditorUtils.getShadowColor(state.selectedOutput);
    ImageUploadModal.show(
      context,
      title: 'En İyi Sonuçlar İçin İpuçları',
      subtitle: 'Ürün fotoğrafı yükle',
      gradient: gradient,
      shadowColor: shadowColor,
      onUploadTap: () {
        Navigator.of(context).pop();
        onPickImage('Outdoor');
      },
      uploadButtonLabel: 'Fotoğraf Yükle',
      formatHint: 'JPEG, PNG veya WEBP (maks. 25 MB)',
    );
  }

  static void showWebsiteUpload(
    BuildContext context,
    WidgetRef ref,
    String label,
    void Function(String label) onPickImage,
  ) {
    final state = ref.read(visualEditorControllerProvider);
    final gradient = VisualEditorUtils.getSelectedGradient(state.selectedOutput);
    final shadowColor = VisualEditorUtils.getShadowColor(state.selectedOutput);
    ImageUploadModal.show(
      context,
      title: 'En İyi Sonuçlar İçin İpuçları',
      subtitle: '$label fotoğrafı yükle',
      gradient: gradient,
      shadowColor: shadowColor,
      onUploadTap: () {
        Navigator.of(context).pop();
        onPickImage(label);
      },
      uploadButtonLabel: 'Fotoğraf Yükle',
      formatHint: 'JPEG, PNG veya WEBP (maks. 25 MB)',
    );
  }
}
