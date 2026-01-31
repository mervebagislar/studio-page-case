import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/features/studio/data/models/generation_result.dart';
import 'package:studio_page_case/features/studio/state/saved/saved_results_state.dart';

final savedResultsControllerProvider =
    NotifierProvider<SavedResultsController, SavedResultsState>(
  SavedResultsController.new,
);

class SavedResultsController extends Notifier<SavedResultsState> {
  @override
  SavedResultsState build() => const SavedResultsState();

  void addResults(List<GenerationResult> newResults) {
    if (newResults.isEmpty) return;
    state = state.addResults(newResults);
  }

  void removeAt(int index) {
    state = state.removeAt(index);
  }

  void clearAll() {
    state = state.copyWith(clear: true);
  }
}
