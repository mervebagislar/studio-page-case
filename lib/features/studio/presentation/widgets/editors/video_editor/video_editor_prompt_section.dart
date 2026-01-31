import 'package:flutter/material.dart';

/// Video editörü prompt alanı: TextField + karakter sayacı + "Hazır" badge. Sadece UI.
class VideoEditorPromptSection extends StatelessWidget {
  const VideoEditorPromptSection({
    super.key,
    required this.controller,
    required this.theme,
    required this.scheme,
    required this.isDark,
    this.hintText,
    this.onChanged,
  });

  final TextEditingController controller;
  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  final String? hintText;
  final ValueChanged<String>? onChanged;

  static const String _defaultHint =
      'Model çayırda doğal ve zarif bir yürüyüş yaparken kamera yavaşça yakınlaşıyor ve kıyafetin her detayını sakin, sinematik bir dokunuşla yakalıyor...';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E293B).withValues(alpha: 0.5)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : scheme.outline.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 8,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: scheme.onSurface,
              height: 1.6,
              letterSpacing: -0.1,
            ),
            decoration: InputDecoration(
              hintText: hintText ?? _defaultHint,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant.withValues(alpha: 0.6),
                height: 1.6,
                letterSpacing: -0.1,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(20),
            ),
            onChanged: onChanged,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  isDark
                      ? const Color(0xFF0F172A).withValues(alpha: 0.5)
                      : const Color(0xFFF8FAFC),
                  isDark
                      ? const Color(0xFF1E293B).withValues(alpha: 0.3)
                      : const Color(0xFFF1F5F9),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.text_fields_rounded,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: 10),
                ListenableBuilder(
                  listenable: controller,
                  builder: (context, _) {
                    return Text(
                      '${controller.text.length} karakter',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    );
                  },
                ),
                const Spacer(),
                ListenableBuilder(
                  listenable: controller,
                  builder: (context, _) {
                    if (controller.text.isEmpty) return const SizedBox.shrink();
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF10B981),
                            const Color(0xFF059669),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF10B981).withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Hazır',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
