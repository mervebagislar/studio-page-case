import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_section_base.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_utils.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_constants.dart';

/// Instagram editörü bölüm sarmalayıcısı. EditorSectionBase (simple variant) kullanır.
class InstagramEditorSection extends StatelessWidget {
  const InstagramEditorSection({
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

  static LinearGradient get _gradient => LinearGradient(
        colors: [
          InstagramEditorUtils.instagramAccent,
          InstagramEditorUtils.instagramAccent.withValues(alpha: 0.85),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return EditorSectionBase(
      variant: EditorSectionVariant.simple,
      title: title,
      subtitle: subtitle,
      icon: icon,
      gradient: _gradient,
      iconShadowColor: InstagramEditorUtils.instagramAccent,
      spacingBetweenHeaderAndChild: AppSpacing.lg,
      child: child,
    );
  }
}
