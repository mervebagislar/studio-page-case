import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Results bottom actions: Select & Save, Go to Saved, Regenerate, End Production. UI only; behavior via callbacks.
class StudioResultsBottomActions extends StatelessWidget {
  const StudioResultsBottomActions({
    super.key,
    required this.selectedCount,
    required this.onSelectAndSave,
    required this.onGoToSavedResults,
    required this.onRegenerate,
    required this.onEndProduction,
  });

  final int selectedCount;
  final VoidCallback onSelectAndSave;
  final VoidCallback onGoToSavedResults;
  final VoidCallback onRegenerate;
  final VoidCallback onEndProduction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onSelectAndSave,
                icon: const Icon(Icons.check_circle_outline_rounded, size: 20),
                label: Text(
                  selectedCount == 0
                      ? 'Seç ve Kaydet'
                      : 'Seç ve Kaydet ($selectedCount)',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: scheme.primary,
                  foregroundColor: scheme.onPrimary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onGoToSavedResults,
                icon: const Icon(Icons.photo_library_rounded, size: 20),
                label: Text(
                  'Kaydedilen görsellere git',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: scheme.surfaceContainerHighest,
                  foregroundColor: scheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onRegenerate();
                },
                icon: const Icon(Icons.refresh_rounded, size: 20),
                label: Text(
                  'Tekrar Oluştur (50 kredi)',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: scheme.primary,
                  foregroundColor: scheme.onPrimary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onEndProduction,
                icon: const Icon(Icons.stop_rounded, size: 20),
                label: Text(
                  'Üretimi Sonlandır',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  side: BorderSide(color: scheme.outline),
                  foregroundColor: scheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
