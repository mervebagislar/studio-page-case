import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/features/studio/data/models/generation.dart';
import 'package:studio_page_case/features/studio/data/models/generation_config.dart';
import 'package:studio_page_case/features/studio/data/models/generation_result.dart';
import 'package:studio_page_case/features/studio/state/generation/generation_type.dart';
import 'package:studio_page_case/features/studio/state/generation/generation_history_controller.dart';
import 'package:studio_page_case/features/studio/state/generation/generation_service_provider.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_state.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_controller.dart';

final studioControllerProvider =
    NotifierProvider<StudioController, StudioState>(StudioController.new);

/// Duration of each loading phase message (mock steps before calling service).
const Duration _kLoadingPhaseDelay = Duration(milliseconds: 600);

class StudioController extends Notifier<StudioState> {
  @override
  StudioState build() => const StudioState();

  void updateConfig(GenerationConfig config) {
    state = state.copyWith(config: config);
  }

  Future<void> generate({String? type}) async {
    if (state.isLoading) return;
    state = state.copyWith(
      isLoading: true,
      results: null,
      selectedResults: [],
      loadingMessage: 'Üretim başlatılıyor…',
      clearError: true,
    );

    await Future.delayed(_kLoadingPhaseDelay);
    state = state.copyWith(loadingMessage: 'Ayarlar işleniyor…');

    await Future.delayed(_kLoadingPhaseDelay);
    state = state.copyWith(loadingMessage: 'İçerik oluşturuluyor…');

    try {
      final service = ref.read(generationServiceProvider);
      final results = await service.generate(state.config.count);
      final effectiveType = type ?? GenerationType.visual.value;

      // Capture visual editor selections if applicable
      GenerationConfig finalConfig = state.config;
      if (effectiveType == GenerationType.visual.value) {
        final visualState = ref.read(visualEditorControllerProvider);
        final selections = <String, dynamic>{
          'Model': visualState.selectedModel,
          'En/Boy': visualState.selectedAspectRatio,
          'Çekim': visualState.selectedShootingAngles.join(', '),
          'Stil': visualState.selectedPhotoStyle,
          'Arka Plan': visualState.selectedBackground,
          'Cinsiyet': visualState.selectedGender ?? visualState.selectedEditorialGender ?? visualState.selectedOutdoorGender,
          'Kadraj': visualState.selectedEditorialFraming ?? visualState.selectedShootingFrames.join(', '),
        }..removeWhere((key, value) => value == null || (value is String && value.isEmpty));
        
        finalConfig = finalConfig.copyWith(visualSelections: selections);
      }

      state = state.copyWith(
        results: results,
        isLoading: false,
        loadingMessage: null,
        lastGenerationType: effectiveType,
        config: finalConfig,
      );

      final generation = Generation(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: effectiveType,
        config: finalConfig,
        results: results,
        createdAt: DateTime.now(),
      );

      ref
          .read(generationHistoryControllerProvider.notifier)
          .addGeneration(generation);
    } catch (e, stackTrace) {
      // Debug-only; in production consider a logging facade.
      debugPrint('[StudioController] Generation error: $e');
      debugPrint(stackTrace.toString());
      final userMessage = _userFriendlyErrorMessage(e);
      state = state.copyWith(
        isLoading: false,
        loadingMessage: null,
        results: null,
        errorMessage: userMessage,
      );
    }
  }

  /// Maps raw error to user-facing message (timeout, network, generic).
  static String _userFriendlyErrorMessage(Object error) {
    final msg = error.toString();
    if (msg.contains('timeout') || msg.contains('TimeoutException')) {
      return 'İstek zaman aşımına uğradı. Lütfen tekrar deneyin.';
    }
    if (msg.contains('network') || msg.contains('SocketException')) {
      return 'Bağlantı hatası. İnternet bağlantınızı kontrol edip tekrar deneyin.';
    }
    return 'Görsel oluşturulurken bir hata oluştu. Lütfen tekrar deneyin.';
  }

  /// Cancels loading UI only; in-flight generation is not aborted.
  void cancelLoading() {
    state = state.copyWith(isLoading: false, loadingMessage: null);
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }

  void selectResult(GenerationResult result) {
    state = state.copyWith(selectedResults: [result]);
  }

  void selectResults(List<GenerationResult> results) {
    state = state.copyWith(selectedResults: results);
  }

  void clearSelection() {
    state = state.copyWith(selectedResults: []);
  }

  /// Exits "selection mode" by clearing selected results; used when user taps back from selection.
  void backToResults() {
    state = state.copyWith(selectedResults: []);
  }

  void clearResults() {
    state = state.copyWith(
      clearResults: true,
      selectedResults: [],
      isLoading: false,
      loadingMessage: null,
    );
  }

  void setResultsFromGeneration(Generation generation) {
    state = state.copyWith(
      results: generation.results,
      selectedResults: [],
      isLoading: false,
      loadingMessage: null,
      lastGenerationType: generation.type,
      config: generation.config,
    );
  }
}
