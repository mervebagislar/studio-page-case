import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/result_placeholder.dart';
import 'package:studio_page_case/features/studio/state/saved/saved_results_controller.dart';

/// Saved results list. UI only; onBack from outside.
class StudioSavedResultsView extends ConsumerWidget {
  const StudioSavedResultsView({
    super.key,
    required this.onBack,
  });

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedResults = ref.watch(savedResultsControllerProvider);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back_rounded),
                style: IconButton.styleFrom(
                  backgroundColor: scheme.surfaceContainerHighest,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Kaydedilen Görseller',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: savedResults.hasResults
              ? RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 400));
                  },
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final crossAxisCount = width > 600 ? 3 : 2;
                      final aspectRatio = width > 600 ? 0.85 : 0.75;
                      return GridView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: aspectRatio,
                        ),
                    itemCount: savedResults.results.length,
                    itemBuilder: (context, index) {
                      final result = savedResults.results[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: scheme.outlineVariant.withValues(alpha: 0.5),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ResultPlaceholder(
                          result: result,
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.circular(20),
                          iconSize: 48,
                        ),
                      );
                    },
                  );
                    },
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.photo_library_outlined,
                        size: 64,
                        color: scheme.onSurfaceVariant.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Henüz kaydedilen görsel yok',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Sonuçlar sayfasında görselleri seçip "Seç" butonuna basarak buraya kaydedebilirsin.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant.withValues(alpha: 0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
