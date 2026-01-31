import 'package:flutter/material.dart';
import 'package:studio_page_case/core/theme/app_theme.dart';
import 'package:studio_page_case/features/studio/data/models/generation_result.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/result_placeholder.dart';


class StudioResultsFullscreenImageView extends StatefulWidget {
  const StudioResultsFullscreenImageView({
    super.key,
    required this.result,
    required this.index,
    required this.total,
    required this.onSelect,
  });

  final GenerationResult result;
  final int index;
  final int total;
  final VoidCallback onSelect;

  @override
  State<StudioResultsFullscreenImageView> createState() =>
      _StudioResultsFullscreenImageViewState();
}

class _StudioResultsFullscreenImageViewState
    extends State<StudioResultsFullscreenImageView> {
  static const double _dismissThreshold = 80;

  double _dragOffset = 0;

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (details.delta.dy > 0) {
      setState(() => _dragOffset += details.delta.dy);
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_dragOffset >= _dismissThreshold) {
      Navigator.of(context).pop();
    } else {
      setState(() => _dragOffset = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final result = widget.result;
    final index = widget.index;
    final total = widget.total;
    final onSelect = widget.onSelect;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: GestureDetector(
        onVerticalDragUpdate: _onVerticalDragUpdate,
        onVerticalDragEnd: _onVerticalDragEnd,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          transform: Matrix4.translationValues(0, _dragOffset * 0.3, 0),
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 3.0,
                  child: ResultPlaceholder(
                    result: result,
                    fit: BoxFit.contain,
                    iconSize: 80,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withValues(alpha: 0.5),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).padding.bottom + 16,
                left: 16,
                right: 16,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '${index + 1} / $total',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Material(
                        color: AppTheme.primaryGradient.colors.first,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          onTap: onSelect,
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle_outline_rounded, color: scheme.onPrimary, size: 22),
                                const SizedBox(width: 8),
                                Text(
                                  'Seç',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: scheme.onPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_dragOffset > 0)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'Bırakarak kapat',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8 * (_dragOffset / _dismissThreshold).clamp(0.0, 1.0)),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
