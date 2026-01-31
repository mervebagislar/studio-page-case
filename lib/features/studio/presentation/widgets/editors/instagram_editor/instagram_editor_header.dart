import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_utils.dart';

/// Instagram editörü sayfa başlığı (animasyonlu). Sadece UI; controller view'dan geçilir.
class InstagramEditorHeader extends StatelessWidget {
  const InstagramEditorHeader({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.headerController,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  final AnimationController headerController;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: headerController,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: headerController,
                curve: Curves.easeOutCubic,
              ),
            ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [scheme.surface, scheme.surface.withValues(alpha: 0)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: InstagramEditorUtils.instagramGradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: InstagramEditorUtils.instagramAccent.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Studio',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      'Instagram Görsel Oluşturucu',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
