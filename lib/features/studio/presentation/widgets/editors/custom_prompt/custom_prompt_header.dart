import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/custom_prompt/custom_prompt_utils.dart';

class CustomPromptHeader extends StatelessWidget {
  const CustomPromptHeader({
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
        position: Tween<Offset>(
          begin: const Offset(0, -0.25),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: headerController,
          curve: Curves.easeOutCubic,
        )),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: CustomPromptUtils.headerGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF9333EA).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.edit_note_rounded,
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
                  'Özel Prompt',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                    height: 1.1,
                  ),
                ),
                Text(
                  'Kendi prompt\'unu yaz',
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
    );
  }
}
