import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_section_base.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_constants.dart';
  
class CustomPromptSection extends StatelessWidget {
  const CustomPromptSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;

  static const Color _accent = Color(0xFF9333EA);
  static final LinearGradient _gradient = LinearGradient(
    colors: [_accent, _accent.withValues(alpha: 0.85)],
  );

  @override
  Widget build(BuildContext context) {
    return EditorSectionBase(
      variant: EditorSectionVariant.simple,
      title: title,
      subtitle: subtitle,
      icon: icon,
      gradient: _gradient,
      iconShadowColor: _accent,
      spacingBetweenHeaderAndChild: AppSpacing.lg,
      child: child,
    );
  }
}
