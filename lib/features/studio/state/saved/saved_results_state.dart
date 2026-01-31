import 'package:studio_page_case/features/studio/data/models/generation_result.dart';

/// Sonuçlar sayfasında "Seç" ile kaydedilen görseller (stüdyo kartında gösterilir).
class SavedResultsState {
  final List<GenerationResult> results;

  const SavedResultsState({List<GenerationResult>? results})
      : results = results ?? const [];

  bool get hasResults => results.isNotEmpty;

  SavedResultsState copyWith({
    List<GenerationResult>? results,
    bool clear = false,
  }) {
    if (clear) return const SavedResultsState();
    return SavedResultsState(
      results: results ?? this.results,
    );
  }

  SavedResultsState addResults(List<GenerationResult> newResults) {
    if (newResults.isEmpty) return this;
    final list = List<GenerationResult>.from(results)..addAll(newResults);
    return SavedResultsState(results: list);
  }

  SavedResultsState removeAt(int index) {
    if (index < 0 || index >= results.length) return this;
    final list = List<GenerationResult>.from(results)..removeAt(index);
    return SavedResultsState(results: list);
  }
}
