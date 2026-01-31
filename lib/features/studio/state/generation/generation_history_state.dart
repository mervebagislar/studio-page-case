import 'package:studio_page_case/features/studio/data/models/generation.dart';

class GenerationHistoryState {
  final List<Generation> generations;
  final Generation? selectedGeneration;

  const GenerationHistoryState({
    this.generations = const [],
    this.selectedGeneration,
  });

  bool get hasGenerations => generations.isNotEmpty;

  GenerationHistoryState copyWith({
    List<Generation>? generations,
    Generation? selectedGeneration,
    bool clearSelection = false,
  }) {
    return GenerationHistoryState(
      generations: generations ?? this.generations,
      selectedGeneration: clearSelection
          ? null
          : (selectedGeneration ?? this.selectedGeneration),
    );
  }

  GenerationHistoryState addGeneration(Generation generation) {
    return copyWith(
      generations: [generation, ...generations],
    );
  }

  GenerationHistoryState clearSelection() {
    return copyWith(clearSelection: true);
  }
}
