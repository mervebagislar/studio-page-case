import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/studio_header.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/studio_loading_view.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_state.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_constants.dart';

/// Loading branch. UI only; state and onBack from outside.
class StudioLoadingScope extends StatelessWidget {
  const StudioLoadingScope({
    super.key,
    required this.state,
    required this.onBack,
    this.generationTab,
  });

  final StudioState state;
  final VoidCallback onBack;
  /// Editor that started generation; used for loading title.
  final EditorTab? generationTab;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = studioLoadingTitleForTab(generationTab);
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) onBack();
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Column(
          children: [
            StudioHeader(state: state),
            Expanded(
              child: StudioLoadingView(
                title: title,
                message: state.loadingMessage,
                loadingStep: loadingStepFromMessage(state.loadingMessage),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: isIOS
                          ? CupertinoButton(
                              onPressed: onBack,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.xmark_circle_fill,
                                    size: 20,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'İptal',
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : TextButton.icon(
                              onPressed: onBack,
                              icon: const Icon(Icons.close_rounded, size: 20),
                              label: const Text('İptal'),
                              style: TextButton.styleFrom(
                                foregroundColor: theme.colorScheme.onSurfaceVariant,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                      child: Text(
                        'İptal edersen üretim arka planda devam eder.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.75),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
