/// Görsel editörde yüklenen / seçilen ürün görselleri (label -> dosya yolu).
class SelectedImagesState {
  final Map<String, String> imagePaths;

  const SelectedImagesState({Map<String, String>? imagePaths})
      : imagePaths = imagePaths ?? const {};

  bool get hasImages => imagePaths.isNotEmpty;

  List<MapEntry<String, String>> get entries => imagePaths.entries.toList();

  SelectedImagesState copyWith({
    Map<String, String>? imagePaths,
    bool clear = false,
  }) {
    if (clear) {
      return const SelectedImagesState();
    }
    return SelectedImagesState(
      imagePaths: imagePaths ?? this.imagePaths,
    );
  }

  SelectedImagesState addImage(String label, String filePath) {
    final updated = Map<String, String>.from(imagePaths);
    updated[label] = filePath;
    return SelectedImagesState(imagePaths: updated);
  }

  SelectedImagesState removeImage(String label) {
    final updated = Map<String, String>.from(imagePaths);
    updated.remove(label);
    return SelectedImagesState(imagePaths: updated);
  }
}
