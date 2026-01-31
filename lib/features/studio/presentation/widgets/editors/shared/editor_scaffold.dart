import 'package:flutter/material.dart';

/// Shared editor layout: optional background, optional header, scrollable body, optional bottom action bar.
/// All editor views use this for consistent structure.
class EditorScaffold extends StatelessWidget {
  const EditorScaffold({
    super.key,
    this.background,
    this.header,
    required this.body,
    this.bottomActionBar,
    this.physics,
    this.backgroundColor,
  });

  final Widget? background;
  final Widget? header;
  final Widget body;
  final Widget? bottomActionBar;
  final ScrollPhysics? physics;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final effectiveBackgroundColor = backgroundColor ?? scheme.surface;

    final content = SafeArea(
      top: false,
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null) header!,
          Expanded(child: body),
          if (bottomActionBar != null) bottomActionBar!,
        ],
      ),
    );

    return Scaffold(
      backgroundColor: effectiveBackgroundColor,
      body: background != null
          ? Stack(
              children: [
                Positioned.fill(child: background!),
                content,
              ],
            )
          : content,
    );
  }
}
