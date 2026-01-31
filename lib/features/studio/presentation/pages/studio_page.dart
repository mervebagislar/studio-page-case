import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/bars/generation_history_bar.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/studio_header.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/studio_snack_bars.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/studio_scopes/studio_dashboard_body.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/studio_scopes/studio_error_scope.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/studio_scopes/studio_loading_scope.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/studio_scopes/studio_results_empty_scope.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/studio_scopes/studio_results_scope.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/studio_scopes/studio_saved_results_view.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/studio_scopes/studio_generations_view.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/studio_scopes/studio_tab_content.dart';
import 'package:studio_page_case/features/studio/state/generation/generation_history_controller.dart';
import 'package:studio_page_case/features/studio/state/generation/generation_type.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_controller.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_navigation_actions.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_constants.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_provider.dart';


const Duration _kResultsFadeDuration = Duration(milliseconds: 250);

class StudioPage extends ConsumerStatefulWidget {
  const StudioPage({super.key});

  @override
  ConsumerState<StudioPage> createState() => _StudioPageState();
}

class _StudioPageState extends ConsumerState<StudioPage> {
  EditorTab? _selectedTab;

  final _visualEditorKey = const ValueKey('visual_editor');
  final _instagramEditorKey = const ValueKey('instagram_editor');
  final _videoEditorKey = const ValueKey('video_editor');
  final _customPromptKey = const ValueKey('custom_prompt');
  final _backgroundEditorKey = const ValueKey('background_editor');
  final _savedResultsKey = const ValueKey('saved_results');
  final _generationsKey = const ValueKey('generations');

  void _setupStudioListeners(WidgetRef ref, BuildContext context) {
    ref.listen(studioControllerProvider, (previous, next) {
      if (next.isLoading) {
        ref.read(productionEndedProvider.notifier).state = false;
      }
      if (previous != null &&
          previous.isLoading &&
          !next.isLoading &&
          next.hasResults &&
          next.results != null &&
          mounted) {
        StudioSnackBars.showSuccess(context, 'İçerik hazır 🎉');
      }
    });
    ref.listen(generationHistoryControllerProvider, (previous, next) {
      if (next.selectedGeneration == null) return;
      if (_selectedTab == EditorTab.savedResults) return;
      final selectedGen = next.selectedGeneration!;
      ref.read(studioControllerProvider.notifier).setResultsFromGeneration(selectedGen);
      ref.read(generationHistoryControllerProvider.notifier).clearSelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupStudioListeners(ref, context);
    final state = ref.watch(studioControllerProvider);
    final theme = Theme.of(context);
    final productionEnded = ref.watch(productionEndedProvider);
    final isShowingSavedResults = _selectedTab == EditorTab.savedResults;
    final isShowingGenerations = _selectedTab == EditorTab.generations;

    final isOnResultsPage = state.hasResults &&
        state.results != null &&
        state.results!.isNotEmpty;
    final isEmptyResults =
        state.results != null && state.results!.isEmpty;
    final isOnSubView = state.isLoading ||
        state.hasError ||
        isOnResultsPage ||
        isEmptyResults ||
        isShowingSavedResults ||
        _selectedTab != null;

    if (state.isLoading) {
      return StudioLoadingScope(
        state: state,
        onBack: () => _handleStudioBack(),
        generationTab: _selectedTab,
      );
    }

    if (state.hasError) {
      final notifier = ref.read(studioControllerProvider.notifier);
      final retryType = state.lastGenerationType ?? GenerationType.visual.value;
      return StudioErrorScope(
        state: state,
        onRetry: () {
          HapticFeedback.lightImpact();
          notifier.clearError();
          notifier.generate(type: retryType);
        },
        onBack: () => _handleStudioBack(),
      );
    }

    if (isEmptyResults) {
      final notifier = ref.read(studioControllerProvider.notifier);
      final retryType = state.lastGenerationType ?? GenerationType.visual.value;
      return StudioResultsEmptyScope(
        state: state,
        onRetry: () {
          HapticFeedback.lightImpact();
          notifier.clearResults();
          notifier.generate(type: retryType);
        },
        onBack: () => _handleStudioBack(),
      );
    }

    if (isOnResultsPage) {
      return TweenAnimationBuilder<double>(
        key: const ValueKey('results_fade'),
        tween: Tween(begin: 0, end: 1),
        duration: _kResultsFadeDuration,
        builder: (context, value, child) => Opacity(
          opacity: Curves.easeOut.transform(value),
          child: child,
        ),
        child: StudioResultsScope(
          results: state.results!,
          onBack: () => _handleStudioBack(),
          // Intentional replace: saved results is not part of the results back stack. Back from Saved = dashboard.
          onGoToSavedResults: () {
            ref.read(studioControllerProvider.notifier).clearResults();
            ref.read(generationHistoryControllerProvider.notifier).clearSelection();
            setState(() => _selectedTab = EditorTab.savedResults);
          },
        ),
      );
    }

    return PopScope(
      canPop: !isOnSubView,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _handleStudioBack();
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Column(
          children: [
            StudioHeader(
              state: state,
              title: _selectedTab != null
                  ? studioHeaderTitleForTab(_selectedTab!)
                  : null,
            ),
            Expanded(
              child: isShowingSavedResults
                  ? StudioSavedResultsView(
                      key: _savedResultsKey,
                      onBack: () => _handleStudioBack(),
                    )
                  : isShowingGenerations
                      ? StudioGenerationsView(
                          key: _generationsKey,
                          onBack: () => _handleStudioBack(),
                        )
                      : _selectedTab == null
                      ? StudioDashboardBody(
                          onTabSelected: (tab) =>
                              setState(() => _selectedTab = tab),
                        )
                      : StudioTabContent(
                          tab: _selectedTab!,
                          visualEditorKey: _visualEditorKey,
                          instagramEditorKey: _instagramEditorKey,
                          videoEditorKey: _videoEditorKey,
                          customPromptKey: _customPromptKey,
                          backgroundEditorKey: _backgroundEditorKey,
                          savedResultsKey: _savedResultsKey,
                          generationsKey: _generationsKey,
                          onSavedResultsBack: () => _handleStudioBack(),
                        ),
            ),
            if (!productionEnded) const GenerationHistoryBar(),
          ],
        ),
      ),
    );
  }

 
  void _handleStudioBack() {
    final state = ref.read(studioControllerProvider);
    if (state.isLoading) {
      ref.read(studioControllerProvider.notifier).cancelLoading();
      return;
    }
    if (state.hasError) {
      ref.read(studioControllerProvider.notifier).clearError();
      return;
    }
    final isOnResultsPage = state.hasResults &&
        state.results != null &&
        state.results!.isNotEmpty;
    final isEmptyResults =
        state.results != null && state.results!.isEmpty;
    if (isOnResultsPage) {
      exitResultsView(ref);
      return;
    }
    if (isEmptyResults) {
      ref.read(studioControllerProvider.notifier).clearResults();
      return;
    }
    if (_selectedTab == EditorTab.savedResults || _selectedTab != null) {
      setState(() => _selectedTab = null);
    }
  }
}
