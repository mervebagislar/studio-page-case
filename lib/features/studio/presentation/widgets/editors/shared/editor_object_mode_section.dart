import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_clear_button.dart';

/// Obje seçimi modu: "Obje Seç" / "Kendin Belirle" kartları + alt içerik slotu + isteğe bağlı temizle.
/// Editorial ve Dış Mekan'da ortak kullanılır.
class EditorObjectModeSection extends StatelessWidget {
  const EditorObjectModeSection({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.selectedMode,
    required this.onObjeSecTap,
    required this.onKendinBelirleTap,
    required this.gradient,
    required this.accent,
    required this.child,
    this.showClear = false,
    this.onClear,
    this.iconObjeSec = Icons.category_rounded,
    this.iconKendinBelirle = Icons.edit_rounded,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  /// 'Obje Seç' | 'Kendin Belirle' | null
  final String? selectedMode;
  final VoidCallback onObjeSecTap;
  final VoidCallback onKendinBelirleTap;
  final LinearGradient gradient;
  final Color accent;
  /// İçerik (Obje Seç → kategorili liste, Kendin Belirle → metin alanı; parent sağlar).
  final Widget child;
  final bool showClear;
  final VoidCallback? onClear;
  final IconData iconObjeSec;
  final IconData iconKendinBelirle;

  @override
  Widget build(BuildContext context) {
    final isObjeSec = selectedMode == 'Obje Seç';
    final isKendinBelirle = selectedMode == 'Kendin Belirle';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildModeCard(
                context,
                label: 'Obje Seç',
                icon: iconObjeSec,
                isSelected: isObjeSec,
                onTap: onObjeSecTap,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildModeCard(
                context,
                label: 'Kendin Belirle',
                icon: iconKendinBelirle,
                isSelected: isKendinBelirle,
                onTap: onKendinBelirleTap,
              ),
            ),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: child,
        ),
        if (showClear && onClear != null) ...[
          const SizedBox(height: 14),
          EditorClearButton(
            theme: theme,
            scheme: scheme,
            onTap: onClear!,
          ),
        ],
      ],
    );
  }

  Widget _buildModeCard(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            gradient: isSelected ? gradient : null,
            color: isSelected ? null : scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : isDark
                      ? scheme.outlineVariant.withValues(alpha: 0.3)
                      : scheme.outlineVariant,
              width: 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
                color: isSelected ? Colors.white : scheme.onSurface,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  label,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: isSelected ? Colors.white : scheme.onSurface,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
