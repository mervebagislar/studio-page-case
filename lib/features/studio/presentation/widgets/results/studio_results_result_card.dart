import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studio_page_case/core/theme/app_theme.dart';
import 'package:studio_page_case/features/studio/data/models/generation_result.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/common/result_placeholder.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/results/studio_results_action_button.dart';

class StudioResultsResultCard extends StatefulWidget {
  const StudioResultsResultCard({
    super.key,
    required this.result,
    required this.index,
    required this.isSelected,
    required this.onTap,
    required this.onSelect,
    required this.onDownload,
  });

  final GenerationResult result;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onSelect;
  final VoidCallback onDownload;

  @override
  State<StudioResultsResultCard> createState() => _StudioResultsResultCardState();
}

class _StudioResultsResultCardState extends State<StudioResultsResultCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Hero(
          tag: widget.result.id,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: widget.isSelected
                  ? Border.all(
                      color: AppTheme.primaryGradient.colors.first,
                      width: 3,
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : theme.colorScheme.shadow.withValues(alpha: 0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                    onTap: widget.onTap,
                    onLongPress: () {
                      HapticFeedback.mediumImpact();
                      widget.onSelect();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: ResultPlaceholder(
                      result: widget.result,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(24),
                      iconSize: 48,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StudioResultsActionButton(
                          icon: widget.isSelected
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: widget.isSelected
                              ? AppTheme.primaryGradient.colors.first
                              : Colors.white,
                          onTap: widget.onSelect,
                        ),
                        const SizedBox(width: 8),
                        StudioResultsActionButton(
                          icon: Icons.download_rounded,
                          color: Colors.white,
                          onTap: widget.onDownload,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: IgnorePointer(
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.7),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    gradient: AppTheme.primaryGradient,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.zoom_in_rounded,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Detay için tıkla',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
