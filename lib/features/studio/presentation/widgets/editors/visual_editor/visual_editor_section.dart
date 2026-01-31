import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_section_base.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart';

/// Bölüm sarmalayıcı: animasyonlu kart + başlık + alt başlık + ikon + child.
/// Sadece UI; state/callback yok.
class VisualEditorSection extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;
  final OutputType outputType;

  const VisualEditorSection({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
    required this.outputType,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = VisualEditorUtils.getSelectedGradient(outputType);
    final shadowColor = VisualEditorUtils.getShadowColor(outputType);
    final sectionChild = child;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, animatedChild) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: animatedChild),
        );
      },
      child: EditorSectionBase(
        title: title,
        subtitle: subtitle,
        icon: icon,
        gradient: gradient,
        iconShadowColor: shadowColor,
        variant: EditorSectionVariant.card,
        child: sectionChild,
      ),
    );
  }
}
