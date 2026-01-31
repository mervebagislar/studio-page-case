import 'package:flutter/material.dart';

class CustomPromptFieldSection extends StatelessWidget {
  const CustomPromptFieldSection({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.controller,
    this.onChanged,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E1B4B).withValues(alpha: 0.3)
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
              hintText:
                  'Minimalist bir stüdyoda, yumuşak ışıklandırma altında, yüksek moda editoryal tarzında ürünü giyen bir modelin profesyonel moda fotoğraf çekimi...',
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
                      ? const Color(0xFF0F0B1E).withValues(alpha: 0.5)
                      : const Color(0xFFFAF5FF),
                  isDark
                      ? const Color(0xFF1E1B4B).withValues(alpha: 0.3)
                      : const Color(0xFFF5F3FF),
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
                  Icons.edit_rounded,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: 10),
                Text(
                  '${controller.text.length} karakter',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                if (controller.text.length > 50)
                  Container(
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
                          'Detaylı',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
  