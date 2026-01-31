import 'package:flutter/material.dart';

/// Studio configuration animasyonlu bölüm sarmalayıcı. Sadece UI.
class StudioConfigurationAnimatedSection extends StatefulWidget {
  const StudioConfigurationAnimatedSection({
    super.key,
    required this.child,
    this.delay = 0,
  });

  final Widget child;
  final int delay;

  @override
  State<StudioConfigurationAnimatedSection> createState() =>
      _StudioConfigurationAnimatedSectionState();
}

class _StudioConfigurationAnimatedSectionState
    extends State<StudioConfigurationAnimatedSection>
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
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.delay), () {
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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
