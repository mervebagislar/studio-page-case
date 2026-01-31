import 'package:flutter/material.dart';
import 'package:studio_page_case/core/theme/app_theme.dart';

/// Studio configuration üst sekme butonları. Sadece UI.
class StudioConfigurationTopNav extends StatelessWidget {
  const StudioConfigurationTopNav({
    super.key,
    required this.currentTab,
  });

  final String currentTab;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StudioConfigurationTabButton(
          label: 'Görsel',
          icon: Icons.image_outlined,
          isSelected: currentTab == 'Görsel',
          gradient: AppTheme.accentGradient,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StudioConfigurationTabButton(
                label: 'AI',
                icon: Icons.auto_awesome_rounded,
                isSelected: false,
                badge: 'Yeni',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StudioConfigurationTabButton(
                label: 'Video',
                icon: Icons.videocam_outlined,
                isSelected: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StudioConfigurationTabButton(
                label: 'Özel',
                icon: Icons.edit_outlined,
                isSelected: false,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StudioConfigurationTabButton(
                label: 'Arka Plan',
                icon: Icons.layers_outlined,
                isSelected: false,
                badge: 'Yeni',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Tek sekme butonu.
class StudioConfigurationTabButton extends StatelessWidget {
  const StudioConfigurationTabButton({
    super.key,
    required this.label,
    required this.icon,
    this.isSelected = false,
    this.gradient,
    this.badge,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final LinearGradient? gradient;
  final String? badge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 58,
          decoration: BoxDecoration(
            gradient: isSelected
                ? (gradient ?? AppTheme.primaryGradient)
                : null,
            color: isSelected ? null : scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : isDark
                      ? scheme.outlineVariant.withValues(alpha: 0.3)
                      : scheme.outlineVariant,
              width: isSelected ? 0 : 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: (gradient?.colors.first ?? const Color(0xFFB75CFF))
                          .withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: onTap ?? () {},
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 22,
                      color: isSelected ? Colors.white : scheme.onSurface,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      label,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: isSelected ? Colors.white : scheme.onSurface,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (badge != null)
          Positioned(
            top: -6,
            right: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7C3AED), Color(0xFF9333EA)],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7C3AED).withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                badge!,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
