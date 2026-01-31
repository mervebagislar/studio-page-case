import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_action_bar_base.dart';

/// Visual Editor "Oluştur" / Generate action bar.
/// Sadece görünüm ve callback; business logic parent'ta kalır.
class VisualEditorActionBar extends StatelessWidget {
  final bool canCreate;
  final String? subtitle;
  final LinearGradient gradient;
  final Color shadowColor;
  final VoidCallback onTap;

  const VisualEditorActionBar({
    super.key,
    required this.canCreate,
    this.subtitle,
    required this.gradient,
    required this.shadowColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return EditorActionBarBase(
      title: 'Oluştur',
      subtitle: subtitle,
      icon: Icons.auto_awesome_rounded,
      gradient: gradient,
      shadowColor: shadowColor,
      onTap: onTap,
      enabled: canCreate,
    );
  }
}
