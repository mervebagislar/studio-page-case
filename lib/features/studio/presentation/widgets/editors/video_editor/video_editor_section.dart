import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_section_base.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/video_editor/video_editor_utils.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_constants.dart';

/// Video editörü bölüm sarmalayıcısı. EditorSectionBase (simple variant) kullanır.
class VideoEditorSection extends StatelessWidget {
  const VideoEditorSection({
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
          VideoEditorUtils.accentColor,
          VideoEditorUtils.accentColor.withValues(alpha: 0.85),
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
      iconShadowColor: VideoEditorUtils.accentColor,
      spacingBetweenHeaderAndChild: AppSpacing.lg,
      child: child,
    );
  }
}
