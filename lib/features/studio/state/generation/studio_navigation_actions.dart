import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/features/studio/state/generation/generation_history_controller.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_controller.dart';
import 'package:studio_page_case/features/studio/state/selection/selected_images_controller.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_controller.dart';

/// Single place for "exit results view": clear studio results, history selection and uploaded images.
/// Use from back button (results), "Kaydedilen görsellere git", and "Üretimi Sonlandır".
void exitResultsView(WidgetRef ref) {
  ref.read(studioControllerProvider.notifier).clearResults();
  ref.read(generationHistoryControllerProvider.notifier).clearSelection();
  ref.read(selectedImagesControllerProvider.notifier).clearAll();
  ref.read(visualEditorControllerProvider.notifier).clearUploadedImages();
}
