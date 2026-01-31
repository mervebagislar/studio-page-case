import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/features/studio/data/models/generation_result.dart';
import 'package:studio_page_case/features/studio/state/generation/generation_type.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_controller.dart';
import 'package:studio_page_case/features/studio/state/saved/saved_results_controller.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_provider.dart';
import 'package:studio_page_case/features/studio/state/generation/generation_history_controller.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_navigation_actions.dart';
import 'package:studio_page_case/features/studio/state/selection/selected_images_controller.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_state.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/studio_header.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/studio_snack_bars.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/results/studio_results_bottom_actions.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/results/studio_results_fullscreen_image_view.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/results/studio_results_result_card.dart';


class StudioResultsDetailPage extends ConsumerStatefulWidget {
  const StudioResultsDetailPage({
    super.key,
    required this.results,
    required this.onGoToSavedResults,
  });

  final List<GenerationResult> results;
  final VoidCallback onGoToSavedResults;

  @override
  ConsumerState<StudioResultsDetailPage> createState() =>
      _StudioResultsDetailPageState();
}

class _StudioResultsDetailPageState
    extends ConsumerState<StudioResultsDetailPage> {
  final Set<int> _selectedIndices = {};

 
  void _showImageFullscreen(int index) {
    final state = ref.watch(studioControllerProvider);
    final results = state.results ?? widget.results;
    if (index >= results.length) return;

    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => StudioResultsFullscreenImageView(
        result: results[index],
        index: index,
        total: results.length,
        onSelect: () {
          _toggleImageSelection(index);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<void> _downloadImage(GenerationResult result) async {
  
    StudioSnackBars.showSuccess(context, 'İndirme özelliği yakında eklenecek');
  }

  void _toggleImageSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
    if (mounted) {
      final count = _selectedIndices.length;
      StudioSnackBars.showSuccess(
        context,
        count > 0 ? '$count resim seçildi' : 'Seçim kaldırıldı',
        duration: const Duration(seconds: 1),
      );
    }
  }

  void _handleSelectAndSave() {
    final resultsToShow = ref.read(studioControllerProvider).results ?? widget.results;
    if (_selectedIndices.isEmpty) {
      StudioSnackBars.showError(context, 'Önce en az bir resim seçin');
      return;
    }
    final selected = resultsToShow
        .asMap()
        .entries
        .where((e) => _selectedIndices.contains(e.key))
        .map((e) => e.value)
        .toList();
    ref.read(studioControllerProvider.notifier).selectResults(selected);
    ref.read(savedResultsControllerProvider.notifier).addResults(selected);
    final count = selected.length;
    setState(() => _selectedIndices.clear());
    if (mounted) {
      StudioSnackBars.showSuccess(
        context,
        count == 1 ? 'Resim seçildi ve kaydedildi' : '$count resim seçildi ve kaydedildi',
      );
    }
  }

  void _handleGoToSavedResults() {
    ref.read(studioControllerProvider.notifier).clearResults();
    ref.read(generationHistoryControllerProvider.notifier).clearSelection();
    widget.onGoToSavedResults();
  }

  void _handleRegenerate() {
    ref.read(productionEndedProvider.notifier).state = false;
    final lastType = ref.read(studioControllerProvider).lastGenerationType ?? GenerationType.visual.value;
    ref.read(studioControllerProvider.notifier).generate(type: lastType);
  }

  Future<void> _refreshResults() async {
    ref.read(productionEndedProvider.notifier).state = false;
    final lastType = ref.read(studioControllerProvider).lastGenerationType ?? GenerationType.visual.value;
    await ref.read(studioControllerProvider.notifier).generate(type: lastType);
  }

  void _handleEndProduction() {
    ref.read(productionEndedProvider.notifier).state = true;
    exitResultsView(ref);
  }

  Widget _buildConfigSummary(StudioState state, ThemeData theme) {
    if (state.config.visualSelections.isEmpty) return const SizedBox.shrink();
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withOpacity(isDark ? 0.3 : 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: scheme.outlineVariant.withOpacity(isDark ? 0.2 : 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tune_rounded, size: 16, color: scheme.primary),
              const SizedBox(width: 8),
              Text(
                'Seçilen Ayarlar',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: scheme.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: state.config.visualSelections.entries.map((e) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: scheme.outlineVariant.withOpacity(0.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${e.key}: ',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      e.value.toString(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studioControllerProvider);
    final theme = Theme.of(context);

    if (!state.hasResults || state.results == null || state.results!.isEmpty) {
      return const SizedBox.shrink();
    }
    
    final resultsToShow = state.results ?? widget.results;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          StudioHeader(
            state: state,
            title: 'Üretim Sonuçları',
           
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshResults,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  SliverToBoxAdapter(
                    child: _buildConfigSummary(state, theme),
                  ),
                  SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.sizeOf(context).width > 600 ? 3 : 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: MediaQuery.sizeOf(context).width > 600 ? 0.85 : 0.75,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => StudioResultsResultCard(
                        result: resultsToShow[index],
                        index: index,
                        isSelected: _selectedIndices.contains(index),
                        onTap: () => _showImageFullscreen(index),
                        onSelect: () => _toggleImageSelection(index),
                        onDownload: () => _downloadImage(resultsToShow[index]),
                      ),
                      childCount: resultsToShow.length,
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 100),
                ),
              ],
              ),
            ),
          ),
          StudioResultsBottomActions(
            selectedCount: _selectedIndices.length,
            onSelectAndSave: _handleSelectAndSave,
            onGoToSavedResults: _handleGoToSavedResults,
            onRegenerate: _handleRegenerate,
            onEndProduction: _handleEndProduction,
          ),
        ],
      ),
    );
  }
}
