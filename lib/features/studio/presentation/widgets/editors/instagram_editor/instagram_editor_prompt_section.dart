import 'package:flutter/material.dart';

/// Instagram Editor prompt / input alanı.
/// Visual editor ile aynı API; validation ve enabled parent'tan gelir.
class InstagramEditorPromptSection extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;
  final String? label;
  final int maxLines;
  final String? errorText;
  final bool enabled;

  const InstagramEditorPromptSection({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
    this.label,
    this.maxLines = 2,
    this.errorText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && label!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            label!,
            style: theme.textTheme.titleSmall?.copyWith(
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: controller,
          onChanged: onChanged,
          enabled: enabled,
          maxLines: maxLines,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
            errorText: errorText,
            filled: true,
            fillColor: scheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: scheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: scheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: scheme.primary,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}
