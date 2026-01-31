import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/studio_header_credit_badge.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/studio_header_leading.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/studio_header_theme_toggle.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_state.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_constants.dart';


const int mockCreditAmount = 400;


class StudioHeader extends ConsumerWidget {
  const StudioHeader({
    super.key,
    required this.state,
    this.title,
  });

  final StudioState state;
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final headerTitle = title ?? 'Studio';

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface.withOpacity(0.95),
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? scheme.outlineVariant.withOpacity(0.3)
                : scheme.outlineVariant,
            width: 1.5,
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.headerGap,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: StudioHeaderLeading(
                      state: state,
                      title: headerTitle,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  StudioHeaderCreditBadge(
                    creditAmount: mockCreditAmount,
                  ),
                  const SizedBox(width: AppSpacing.iconBox),
                  StudioHeaderThemeToggle(scheme: scheme, isDark: isDark),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
