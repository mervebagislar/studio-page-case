import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_utils.dart';

/// Instagram editörü ürün fotoğrafı yükleme alanı. Sadece UI; imagePath ve callback'ler view'dan geçilir.
class InstagramEditorImageUploadSection extends StatelessWidget {
  const InstagramEditorImageUploadSection({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.imagePath,
    required this.shimmerAnimation,
    required this.onUploadTap,
    required this.onRemoveTap,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  final String? imagePath;
  final AnimationController shimmerAnimation;
  final VoidCallback onUploadTap;
  final VoidCallback onRemoveTap;

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return _buildLoadedState(context);
    }
    return _buildEmptyState(context);
  }

  Widget _buildLoadedState(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  scheme.surfaceContainerHighest.withValues(alpha: 0.7),
                  scheme.surfaceContainerHigh.withValues(alpha: 0.5),
                ]
              : [
                  scheme.surfaceContainerHighest.withValues(alpha: 0.6),
                  scheme.surfaceContainerHigh.withValues(alpha: 0.4),
                ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: InstagramEditorUtils.instagramAccent.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(22),
            ),
            child: Image.file(
              File(imagePath!),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 200,
                color: scheme.surfaceContainerHigh,
                child: Icon(
                  Icons.broken_image_rounded,
                  size: 48,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: InstagramEditorUtils.instagramAccent,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Yüklenen ürün',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: scheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Ürün yüklendi',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: scheme.onSurface,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.swap_horiz_rounded,
                        color: InstagramEditorUtils.instagramAccent,
                      ),
                      onPressed: onUploadTap,
                      tooltip: 'Değiştir',
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        color: scheme.onSurfaceVariant,
                      ),
                      onPressed: onRemoveTap,
                      tooltip: 'Kaldır',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: onRemoveTap,
                  icon: Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: scheme.error,
                  ),
                  label: Text(
                    'Kaldır',
                    style: TextStyle(
                      color: scheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return GestureDetector(
      onTap: onUploadTap,
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF0F2830).withValues(alpha: 0.5)
              : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : InstagramEditorUtils.instagramAccent.withValues(alpha: 0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: InstagramEditorUtils.instagramAccent.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: shimmerAnimation,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [
                          shimmerAnimation.value - 0.3,
                          shimmerAnimation.value,
                          shimmerAnimation.value + 0.3,
                        ],
                        colors: [
                          Colors.transparent,
                          isDark
                              ? Colors.white.withValues(alpha: 0.03)
                              : InstagramEditorUtils.instagramAccent.withValues(alpha: 0.05),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            InstagramEditorUtils.instagramAccent.withValues(alpha: 0.15),
                            InstagramEditorUtils.instagramAccent.withValues(alpha: 0.08),
                          ],
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: InstagramEditorUtils.instagramAccent.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.add_photo_alternate_rounded,
                        size: 48,
                        color: InstagramEditorUtils.instagramAccent,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Fotoğraf Yükle',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tıklayarak görsel seç',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
