import 'dart:io';
import 'package:flutter/material.dart';

/// Tek bir yükleme slotu: etiket + dosya (null = boş).
class EditorImageUploadSlot {
  const EditorImageUploadSlot({required this.label, this.file});
  final String label;
  final File? file;
}

/// Editor'lerde tekrar eden image upload UI: boş/dolu state, grid/row layout.
/// Modal açma ve upload logic parent'ta kalır; sadece UI.
class EditorImageUploadArea extends StatelessWidget {
  const EditorImageUploadArea({
    super.key,
    required this.slots,
    required this.onSlotTap,
    required this.shimmerAnimation,
    required this.accentColor,
    this.cardHeight = 170,
    this.isSingleLayout = false,
    this.placeholderTitle,
    this.placeholderSubtitle = 'Tıklayarak yükle',
    this.filledBadgeText,
    this.singleEmptyBackgroundColor,
  });

  final List<EditorImageUploadSlot> slots;
  final ValueChanged<int> onSlotTap;
  final Animation<double> shimmerAnimation;
  final Color accentColor;
  final double cardHeight;
  final bool isSingleLayout;
  final String? placeholderTitle;
  final String placeholderSubtitle;
  final String? filledBadgeText;
  /// Single layout boş state arka planı (null = scheme.surfaceContainerHighest / white).
  final Color? singleEmptyBackgroundColor;

  Widget _buildCard({
    required BuildContext context,
    required EditorImageUploadSlot slot,
    required int index,
    required String emptyTitle,
    required String emptySubtitle,
    required String filledBadge,
    required double height,
    Color? emptyBackgroundColor,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final hasImage = slot.file != null;
    final isSingle = isSingleLayout && slots.length == 1;
    final effectiveEmptyBg = emptyBackgroundColor ?? (isDark ? scheme.surfaceContainerHighest : Colors.white);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: height,
      decoration: BoxDecoration(
        color: hasImage ? null : effectiveEmptyBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: hasImage ? accentColor : accentColor.withValues(alpha: 0.2),
          width: hasImage ? 3 : 2,
        ),
        boxShadow: hasImage
            ? [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                  spreadRadius: 1,
                ),
              ]
            : [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => onSlotTap(index),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: hasImage
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(slot.file!, fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: isSingle ? 0.7 : 0.75),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: isSingle ? 16 : 14,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isSingle ? 14 : 10,
                                vertical: isSingle ? 8 : 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.4),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle_rounded,
                                    size: isSingle ? 18 : 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: isSingle ? 8 : 6),
                                  Flexible(
                                    child: Text(
                                      filledBadge,
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: isSingle ? null : 10,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Stack(
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
                                      : accentColor.withValues(alpha: 0.05),
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
                              padding: EdgeInsets.all(isSingle ? 20 : 14),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    accentColor.withValues(alpha: 0.15),
                                    accentColor.withValues(alpha: 0.08),
                                  ],
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: accentColor.withValues(alpha: 0.3),
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.add_photo_alternate_rounded,
                                size: isSingle ? 48 : 28,
                                color: accentColor,
                              ),
                            ),
                            SizedBox(height: isSingle ? 20 : 14),
                            Text(
                              emptyTitle,
                              textAlign: TextAlign.center,
                              style: (isSingle
                                      ? theme.textTheme.titleLarge
                                      : theme.textTheme.bodyLarge)
                                  ?.copyWith(
                                color: scheme.onSurface,
                                fontWeight: FontWeight.w700,
                                letterSpacing: isSingle ? -0.5 : null,
                              ),
                            ),
                            SizedBox(height: isSingle ? 8 : 6),
                            Text(
                              emptySubtitle,
                              textAlign: TextAlign.center,
                              style: (isSingle
                                      ? theme.textTheme.bodyMedium
                                      : theme.textTheme.bodySmall)
                                  ?.copyWith(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSingleLayout && slots.length == 1) {
      return _buildCard(
        context: context,
        slot: slots.first,
        index: 0,
        emptyTitle: placeholderTitle ?? slots.first.label,
        emptySubtitle: placeholderSubtitle,
        filledBadge: filledBadgeText ?? slots.first.label,
        height: cardHeight,
        emptyBackgroundColor: singleEmptyBackgroundColor,
      );
    }
    return Row(
      children: [
        for (int i = 0; i < slots.length; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          Expanded(
            child: _buildCard(
              context: context,
              slot: slots[i],
              index: i,
              emptyTitle: slots[i].label,
              emptySubtitle: placeholderSubtitle,
              filledBadge: slots[i].label,
              height: cardHeight,
              emptyBackgroundColor: null,
            ),
          ),
        ],
      ],
    );
  }
}
