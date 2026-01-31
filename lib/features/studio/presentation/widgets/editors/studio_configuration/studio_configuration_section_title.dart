import 'package:flutter/material.dart';

/// Studio configuration bölüm başlığı. Sadece UI.
class StudioConfigurationSectionTitle extends StatelessWidget {
  const StudioConfigurationSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.3,
      ),
    );
  }
}
