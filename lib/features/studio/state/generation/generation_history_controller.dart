import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/features/studio/data/models/generation.dart';
import 'package:studio_page_case/features/studio/state/generation/generation_history_state.dart';

final generationHistoryControllerProvider =
    NotifierProvider<GenerationHistoryController, GenerationHistoryState>(
  GenerationHistoryController.new,
);

class GenerationHistoryController extends Notifier<GenerationHistoryState> {
  @override
  GenerationHistoryState build() => const GenerationHistoryState();

  void addGeneration(Generation generation) {
    state = state.addGeneration(generation);
  }

  void selectGeneration(Generation generation) {
    state = state.copyWith(selectedGeneration: generation);
  }

  void clearSelection() {
    state = state.clearSelection();
  }
}
