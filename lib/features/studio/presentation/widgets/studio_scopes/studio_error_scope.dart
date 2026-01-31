import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/studio_error_view.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/studio_header.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_state.dart';

/// Error branch. UI only; state, onRetry, onBack from outside.
class StudioErrorScope extends StatelessWidget {
  const StudioErrorScope({
    super.key,
    required this.state,
    required this.onRetry,
    required this.onBack,
  });

  final StudioState state;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
              child: StudioErrorView(
                message: state.errorMessage!,
                onRetry: onRetry,
                onBack: onBack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
