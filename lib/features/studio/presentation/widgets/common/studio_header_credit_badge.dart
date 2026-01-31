import 'package:flutter/material.dart';
import 'package:studio_page_case/core/theme/app_theme.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_constants.dart';


class StudioHeaderCreditBadge extends StatelessWidget {
  const StudioHeaderCreditBadge({
    super.key,
    required this.creditAmount,
  });

  final int creditAmount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.headerGap,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB75CFF).withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.auto_awesome,
            size: 18,
            color: Colors.white,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            '$creditAmount',
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
