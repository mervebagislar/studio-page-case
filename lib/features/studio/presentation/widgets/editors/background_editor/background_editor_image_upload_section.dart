import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/background_editor/background_editor_utils.dart';

class BackgroundEditorImageUploadSection extends StatelessWidget {
  const BackgroundEditorImageUploadSection({
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
  final Animation<double> shimmerAnimation;
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
        gradient: BackgroundEditorUtils.headerGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF5C9D).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
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
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 220,
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
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Yüklenen görsel',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Arka plan bu görsel üzerinde değiştirilecek',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.swap_horiz_rounded, color: Colors.white),
                  onPressed: onUploadTap,
                  tooltip: 'Değiştir',
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                  onPressed: onRemoveTap,
                  tooltip: 'Kaldır',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onUploadTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
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
                  : const Color(0xFF06B6D4).withValues(alpha: 0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.2)
                    : const Color(0xFF06B6D4).withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
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
                              : const Color(0xFF06B6D4).withValues(alpha: 0.05),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  );
                },
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF06B6D4).withValues(alpha: 0.15),
                            const Color(0xFF14B8A6).withValues(alpha: 0.15),
                          ],
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF06B6D4).withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.add_photo_alternate_rounded,
                        size: 48,
                        color: const Color(0xFF06B6D4),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Fotoğraf yükle',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'PNG, JPG (max. 10MB)',
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
