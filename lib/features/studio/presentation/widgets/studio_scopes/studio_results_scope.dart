import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/data/models/generation_result.dart';
import 'package:studio_page_case/features/studio/presentation/pages/studio_results_detail_page.dart';

/// Studio results branch. UI only; results, onBack and onGoToSavedResults come from outside.
class StudioResultsScope extends StatelessWidget {
  const StudioResultsScope({
    super.key,
    required this.results,
    required this.onBack,
    required this.onGoToSavedResults,
  });

  final List<GenerationResult> results;
  final VoidCallback onBack;
  final VoidCallback onGoToSavedResults;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) onBack();
      },
      child: StudioResultsDetailPage(
        key: ValueKey('results_${results.length}'),
        results: results,
        onGoToSavedResults: onGoToSavedResults,
      ),
    );
  }
}
