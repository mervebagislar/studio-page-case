import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/core/theme/app_theme.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_controller.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_navigation_actions.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_state.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_constants.dart';

/// Header leading: back button (when applicable) + status icon + logo + title. No ref.watch.
class StudioHeaderLeading extends ConsumerWidget {
  const StudioHeaderLeading({
    super.key,
    required this.state,
    required this.title,
  });

  final StudioState state;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    Widget? leadingButton;
    if (state.hasSelection) {
      leadingButton = IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () =>
            ref.read(studioControllerProvider.notifier).backToResults(),
      );
    } else if (state.hasResults) {
      leadingButton = IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () => exitResultsView(ref),
        tooltip: 'Seçeneklere Dön',
      );
    }

    return Row(
      children: [
        if (leadingButton != null) ...[
          leadingButton,
          const SizedBox(width: AppSpacing.sm),
        ],
        Container(
          padding: const EdgeInsets.all(AppSpacing.statusIconPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.statusBox),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: state.isLoading
              ? const Icon(
                  Icons.hourglass_empty_rounded,
                  color: Color(0xFF00C6FF),
                  size: 22,
                )
              : state.hasResults
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF10B981),
                      size: 22,
                    )
                  : Image.asset(
                      'assets/logo.png',
                      width: 22,
                      height: 22,
                      fit: BoxFit.contain,
                    ),
        ),
        const SizedBox(width: AppSpacing.headerGap),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                isDark ? 'assets/T2-dark.png' : 'assets/T2.png',
                height: 16,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      gradient: state.isLoading
                          ? LinearGradient(
                              colors: [
                                scheme.secondary,
                                scheme.secondary.withValues(alpha: 0.5),
                              ],
                            )
                          : state.hasResults
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFF10B981),
                                    Color(0xFF059669),
                                  ],
                                )
                              : AppTheme.primaryGradient,
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
