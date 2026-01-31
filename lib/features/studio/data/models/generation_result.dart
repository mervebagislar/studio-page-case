/// Single result item. Mock: imageUrl can be "asset:path"; production: HTTP URL. Fallback: gradient by colorIndex.
class GenerationResult {
  final String id;
  /// Image URL: production HTTP URL; mock "asset:path" (see GenerationService.kAssetUrlPrefix).
  final String? imageUrl;
  /// Thumbnail URL (optional); mock uses same as imageUrl.
  final String? thumbnailUrl;
  /// Index 0..5 for gradient fallback when image fails or is null.
  final int colorIndex;
  final DateTime createdAt;

  const GenerationResult({
    required this.id,
    this.imageUrl,
    this.thumbnailUrl,
    required this.colorIndex,
    required this.createdAt,
  });
}
