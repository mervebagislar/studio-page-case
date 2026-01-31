import 'package:flutter/material.dart';
import 'package:studio_page_case/core/theme/app_theme.dart';

/// Studio configuration Generate butonu. Sadece UI; onPressed view'dan geçilir.
class StudioConfigurationGenerateButton extends StatefulWidget {
  const StudioConfigurationGenerateButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  State<StudioConfigurationGenerateButton> createState() =>
      _StudioConfigurationGenerateButtonState();
}

class _StudioConfigurationGenerateButtonState
    extends State<StudioConfigurationGenerateButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFB75CFF).withValues(alpha: 0.5),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: const Color(0xFFFF5C9D).withValues(alpha: 0.3),
              blurRadius: 32,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              _controller.forward().then((_) => _controller.reverse());
              widget.onPressed();
            },
            borderRadius: BorderRadius.circular(20),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.auto_awesome_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'Generate',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
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
