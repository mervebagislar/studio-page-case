import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/studio_header.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_state.dart';

/// Empty results branch when API returns an empty list. UI only; onRetry, onBack from outside.
class StudioResultsEmptyScope extends StatelessWidget {
  const StudioResultsEmptyScope({
    super.key,
    required this.state,
    required this.onRetry,
    required this.onBack,
  });

  final StudioState state;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) onBack();
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Column(
          children: [
            StudioHeader(state: state),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image_not_supported_outlined,
                        size: 64,
                        color: scheme.onSurfaceVariant.withValues(alpha: 0.6),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Sonuç bulunamadı',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Bu sefer görsel oluşturulamadı. Tekrar deneyebilirsin.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 28),
                      FilledButton.icon(
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          onRetry();
                        },
                        icon: const Icon(Icons.refresh_rounded, size: 20),
                        label: const Text('Tekrar Dene'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: onBack,
                        child: const Text('Geri dön'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
