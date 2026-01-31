import 'package:studio_page_case/features/studio/data/models/generation_config.dart';
import 'package:studio_page_case/features/studio/data/models/generation_result.dart';

class StudioState {
  final List<GenerationResult>? results;
  final List<GenerationResult> selectedResults;
  final bool isLoading;
  final GenerationConfig config;
  final String? loadingMessage;
  /// User-facing error message; null when no error.
  final String? errorMessage;
  /// Last successful generation type; used by "Tekrar Oluştur".
  final String? lastGenerationType;

  const StudioState({
    this.results,
    this.selectedResults = const [],
    this.isLoading = false,
    GenerationConfig? config,
    this.loadingMessage,
    this.errorMessage,
    this.lastGenerationType,
  }) : config = config ?? const GenerationConfig();

  bool get isIdle => !isLoading && results == null && !hasError;
  bool get hasResults => results != null && results!.isNotEmpty;
  bool get hasSelection => selectedResults.isNotEmpty;
  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  StudioState copyWith({
    List<GenerationResult>? results,
    List<GenerationResult>? selectedResults,
    bool? isLoading,
    GenerationConfig? config,
    String? loadingMessage,
    String? errorMessage,
    String? lastGenerationType,
    bool clearResults = false,
    bool clearError = false,
  }) {
    return StudioState(
      results: clearResults ? null : (results ?? this.results),
      selectedResults: selectedResults ?? this.selectedResults,
      isLoading: isLoading ?? this.isLoading,
      config: config ?? this.config,
      loadingMessage: loadingMessage ?? this.loadingMessage,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      lastGenerationType: lastGenerationType ?? this.lastGenerationType,
    );
  }
}
