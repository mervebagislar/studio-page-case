import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_utils.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_gender_row.dart';

/// Instagram editörü cinsiyet + manken özellikleri. Paylaşılan [EditorGenderRow] kullanır.
class InstagramEditorGenderSection extends StatelessWidget {
  const InstagramEditorGenderSection({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.selectedGender,
    required this.onGenderSelected,
    required this.mankenCard,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  final String? selectedGender;
  final ValueChanged<String> onGenderSelected;
  final Widget mankenCard;

  @override
  Widget build(BuildContext context) {
    return EditorGenderRow(
      theme: theme,
      scheme: scheme,
      isDark: isDark,
      selectedGender: selectedGender,
      onGenderSelected: onGenderSelected,
      gradient: InstagramEditorUtils.instagramGradient,
      accent: InstagramEditorUtils.instagramAccent,
      trailingChild: mankenCard,
    );
  }
}
