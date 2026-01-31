import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_view.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/instagram_editor/instagram_editor_view.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/video_editor/video_editor_view.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/custom_prompt/custom_prompt_view.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/background_editor/background_editor_view.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/studio_scopes/studio_saved_results_view.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/studio_scopes/studio_generations_view.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_constants.dart';

/// Tab content: view per EditorTab. UI only; keys and onSavedResultsBack from outside.
class StudioTabContent extends StatelessWidget {
  const StudioTabContent({
    super.key,
    required this.tab,
    required this.visualEditorKey,
    required this.instagramEditorKey,
    required this.videoEditorKey,
    required this.customPromptKey,
    required this.backgroundEditorKey,
    required this.savedResultsKey,
    required this.generationsKey,
    required this.onSavedResultsBack,
  });

  final EditorTab tab;
  final Key visualEditorKey;
  final Key instagramEditorKey;
  final Key videoEditorKey;
  final Key customPromptKey;
  final Key backgroundEditorKey;
  final Key savedResultsKey;
  final Key generationsKey;
  final VoidCallback onSavedResultsBack;

  @override
  Widget build(BuildContext context) {
    switch (tab) {
      case EditorTab.visual:
        return VisualEditorView(key: visualEditorKey);
      case EditorTab.instagram:
        return InstagramEditorView(key: instagramEditorKey);
      case EditorTab.video:
        return VideoEditorView(key: videoEditorKey);
      case EditorTab.customPrompt:
        return CustomPromptView(key: customPromptKey);
      case EditorTab.background:
        return BackgroundEditorView(key: backgroundEditorKey);
      case EditorTab.savedResults:
        return StudioSavedResultsView(
          key: savedResultsKey,
          onBack: onSavedResultsBack,
        );
      case EditorTab.generations:
        return StudioGenerationsView(
          key: generationsKey,
          onBack: onSavedResultsBack,
        );
    }
  }
}
