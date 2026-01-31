import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/features/studio/state/selection/selected_images_state.dart';

final selectedImagesControllerProvider =
    NotifierProvider<SelectedImagesController, SelectedImagesState>(
  SelectedImagesController.new,
);

class SelectedImagesController extends Notifier<SelectedImagesState> {
  @override
  SelectedImagesState build() => const SelectedImagesState();

  void addImage(String label, String filePath) {
    state = state.addImage(label, filePath);
  }

  void removeImage(String label) {
    state = state.removeImage(label);
  }

  void clearAll() {
    state = state.copyWith(clear: true);
  }

  void setImages(Map<String, String> paths) {
    state = SelectedImagesState(imagePaths: Map.from(paths));
  }
}
