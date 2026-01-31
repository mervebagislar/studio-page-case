import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/data/models/generation_result.dart';
import 'package:studio_page_case/features/studio/data/generation_service.dart';

/// Shows result image (asset or network URL) or gradient placeholder.
/// Mock uses imageUrl with "asset:path"; production uses HTTP URL.
class ResultPlaceholder extends StatelessWidget {
  final GenerationResult result;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final double? iconSize;

  const ResultPlaceholder({
    super.key,
    required this.result,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.iconSize,
  });

  static const List<LinearGradient> _gradients = [
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFEC4899), Color(0xFFF43F5E)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF14B8A6), Color(0xFF06B6D4)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF9333EA), Color(0xFFC026D3)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF0EA5E9), Color(0xFF3B82F6)],
    ),
  ];

  Widget _buildGradientPlaceholder() {
    final gradient = _gradients[result.colorIndex % _gradients.length];
    final size = iconSize ?? 48.0;
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: Center(
        child: Icon(
          Icons.image_rounded,
          size: size,
          color: Colors.white.withValues(alpha: 0.95),
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    final isAsset = imageUrl.startsWith(kAssetUrlPrefix);
    final pathOrUrl = isAsset ? imageUrl.substring(kAssetUrlPrefix.length) : imageUrl;
    return isAsset
        ? Image.asset(
            pathOrUrl,
            fit: fit,
            errorBuilder: (_, __, ___) => _buildGradientPlaceholder(),
          )
        : Image.network(
            pathOrUrl,
            fit: fit,
            errorBuilder: (_, __, ___) => _buildGradientPlaceholder(),
          );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = result.imageUrl != null && result.imageUrl!.isNotEmpty
        ? _buildImage(result.imageUrl!)
        : _buildGradientPlaceholder();
    if (borderRadius != null) {
      content = ClipRRect(
        borderRadius: borderRadius!,
        child: content,
      );
    }
    return content;
  }
}
