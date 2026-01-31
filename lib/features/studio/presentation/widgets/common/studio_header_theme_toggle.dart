import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/core/theme/theme_mode_provider.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_constants.dart';

/// Theme toggle. Only this widget uses ref.watch(themeModeProvider) so only it rebuilds on theme change.
class StudioHeaderThemeToggle extends ConsumerWidget {
  const StudioHeaderThemeToggle({
    super.key,
    required this.scheme,
    required this.isDark,
  });

  final ColorScheme scheme;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.statusBox),
        border: Border.all(
          color: isDark
              ? scheme.outlineVariant.withOpacity(0.3)
              : scheme.outlineVariant,
          width: 1.5,
        ),
      ),
      child: IconButton(
        icon: Icon(
          isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          color: scheme.onSurface,
          size: 22,
        ),
        onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
      ),
    );
  }
}
