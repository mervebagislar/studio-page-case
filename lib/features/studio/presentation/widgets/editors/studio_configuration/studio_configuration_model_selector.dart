import 'package:flutter/material.dart';
import 'package:studio_page_case/core/theme/app_theme.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/editor_model_type_row.dart';

/// Studio configuration model tipi seçici. Paylaşılan [EditorModelTypeRow] kullanır.
class StudioConfigurationModelSelector extends StatelessWidget {
  const StudioConfigurationModelSelector({
    super.key,
    required this.selected,
    this.onModelSelected,
  });

  final String selected;
  final ValueChanged<String?>? onModelSelected;

  static const Color _accent = Color(0xFF00C6FF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return EditorModelTypeRow(
      theme: theme,
      scheme: scheme,
      isDark: isDark,
      selectedModel: selected,
      onModelSelected: onModelSelected ?? (_) {},
      gradient: AppTheme.accentGradient,
      accent: _accent,
    );
  }
}
