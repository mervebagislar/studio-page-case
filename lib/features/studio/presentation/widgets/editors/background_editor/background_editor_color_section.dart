import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/background_editor/background_editor_utils.dart';


class BackgroundEditorColorSection extends StatelessWidget {
  const BackgroundEditorColorSection({
    super.key,
    required this.theme,
    required this.scheme,
    required this.isDark,
    required this.selectedBackgroundColor,
    required this.customColor,
    required this.onColorSelected,
    required this.onCustomColorPicked,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;
  final String? selectedBackgroundColor;
  final Color customColor;
  final ValueChanged<String?> onColorSelected;
  final ValueChanged<Color> onCustomColorPicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildColorCard(
                context,
                'Beyaz',
                Colors.white,
                Icons.wb_sunny_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildColorCard(
                context,
                'Gri',
                Colors.grey.shade400,
                Icons.cloud_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildColorCard(
                context,
                'Siyah',
                Colors.black,
                Icons.dark_mode_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildColorCard(
                context,
                'Bej',
                const Color(0xFFF5F5DC),
                Icons.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildCustomColorCard(context),
            ),
            const SizedBox(width: 12),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildColorCard(
    BuildContext context,
    String label,
    Color color,
    IconData icon,
  ) {
    final isSelected = selectedBackgroundColor == label;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onColorSelected(label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: isSelected ? BackgroundEditorUtils.modernCyanGradient : null,
            color: isSelected
                ? null
                : isDark
                    ? const Color(0xFF0F2830).withValues(alpha: 0.5)
                    : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : scheme.outline.withValues(alpha: 0.2),
              width: 2,
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: const Color(0xFF06B6D4).withValues(alpha: 0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              if (!isSelected)
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.5)
                        : isDark
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.grey.withValues(alpha: 0.3),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: isSelected
                    ? Icon(
                        Icons.check_rounded,
                        color: color.computeLuminance() > 0.5
                            ? Colors.black
                            : Colors.white,
                        size: 24,
                      )
                    : null,
              ),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: isSelected ? Colors.white : scheme.onSurface,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomColorCard(BuildContext context) {
    final isSelected = selectedBackgroundColor == 'Özel Renk';

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final Color? pickedColor = await showDialog<Color>(
            context: context,
            builder: (dialogContext) => BackgroundEditorHexColorDialog(
              initialColor: customColor,
              theme: theme,
              scheme: scheme,
              isDark: isDark,
            ),
          );
          if (pickedColor != null) {
            onCustomColorPicked(pickedColor);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: isSelected ? BackgroundEditorUtils.modernCyanGradient : null,
            color: isSelected
                ? null
                : isDark
                    ? const Color(0xFF0F2830).withValues(alpha: 0.5)
                    : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : scheme.outline.withValues(alpha: 0.2),
              width: 2,
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: const Color(0xFF06B6D4).withValues(alpha: 0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              if (!isSelected)
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      customColor,
                      customColor.withValues(alpha: 0.8),
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.5)
                        : isDark
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.grey.withValues(alpha: 0.3),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: isSelected
                    ? Icon(
                        Icons.check_rounded,
                        color: customColor.computeLuminance() > 0.5
                            ? Colors.black
                            : Colors.white,
                        size: 24,
                      )
                    : Icon(
                        Icons.palette_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
              ),
              const SizedBox(height: 12),
              Text(
                'Özel Renk',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: isSelected ? Colors.white : scheme.onSurface,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dialog shown when "Özel Renk" card is tapped: hex input for custom color.
class BackgroundEditorHexColorDialog extends StatefulWidget {
  const BackgroundEditorHexColorDialog({
    super.key,
    required this.initialColor,
    required this.theme,
    required this.scheme,
    required this.isDark,
  });

  final Color initialColor;
  final ThemeData theme;
  final ColorScheme scheme;
  final bool isDark;

  @override
  State<BackgroundEditorHexColorDialog> createState() =>
      _BackgroundEditorHexColorDialogState();
}

class _BackgroundEditorHexColorDialogState
    extends State<BackgroundEditorHexColorDialog> {
  late TextEditingController _controller;
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: BackgroundEditorUtils.colorToHex(widget.initialColor));
    _currentColor = widget.initialColor;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _applyHex() {
    final color = BackgroundEditorUtils.hexToColor(_controller.text);
    if (color != null && mounted) {
      Navigator.of(context).pop(color);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final scheme = widget.scheme;
    final isDark = widget.isDark;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF0F2830).withValues(alpha: 0.95)
                  : Colors.white.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.1),
              ),
            ),
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '3) Özel Renk (Hex)',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  BackgroundEditorUtils.colorToHex(_currentColor),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Hex renk kodu girin (örn: #FF6B6B)',
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                    filled: true,
                    fillColor: isDark
                        ? const Color(0xFF0F2830).withValues(alpha: 0.5)
                        : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.1)
                            : scheme.outline.withValues(alpha: 0.2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF06B6D4),
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                  onChanged: (value) {
                    final color = BackgroundEditorUtils.hexToColor(value);
                    if (color != null) {
                      setState(() => _currentColor = color);
                    }
                  },
                  onSubmitted: (_) => _applyHex(),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('İptal'),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: _applyHex,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF06B6D4),
                      ),
                      child: const Text('Tamam'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
