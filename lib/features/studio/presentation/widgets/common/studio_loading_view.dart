import 'package:flutter/material.dart';
import 'package:studio_page_case/core/theme/app_theme.dart';

class StudioLoadingView extends StatefulWidget {
 
  final String? title;

  final String? message;
 
  final int? loadingStep;

  const StudioLoadingView({
    super.key,
    this.title,
    this.message,
    this.loadingStep,
  });

  @override
  State<StudioLoadingView> createState() => _StudioLoadingViewState();
}

class _StudioLoadingViewState extends State<StudioLoadingView>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final trypixLogo = isDark ? 'assets/T3-.png' : 'assets/T3-dark-.png';

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  theme.scaffoldBackgroundColor,
                  const Color(0xFFB75CFF).withValues(alpha: 0.08),
                  theme.scaffoldBackgroundColor,
                ]
              : [
                  theme.scaffoldBackgroundColor,
                  const Color(0xFFB75CFF).withValues(alpha: 0.05),
                  const Color(0xFFFF5C9D).withValues(alpha: 0.05),
                ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          final loadingColor =
                              isDark ? Colors.white : Colors.black87;
                          final loadingColorFaded =
                              loadingColor.withValues(alpha: 0.2);
                          final step = widget.loadingStep;
                          final progress =
                              step != null && step >= 1 && step <= 3
                                  ? step / 3.0
                                  : null;
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 140,
                                  height: 140,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    value: progress,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      loadingColor,
                                    ),
                                    backgroundColor: loadingColorFaded,
                                  ),
                                ),
                                Image.asset(
                                  trypixLogo,
                                  height: 100,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: AppTheme.primaryGradient,
                                      ),
                                      child: const Icon(
                                        Icons.auto_awesome_rounded,
                                        size: 48,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 48),
                      ShaderMask(
                        shaderCallback: (bounds) =>
                            AppTheme.primaryGradient.createShader(bounds),
                        child: Text(
                          widget.title ?? 'Oluşturuluyor',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      if (widget.message != null) ...[
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest
                                .withValues(
                              alpha: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isDark
                                  ? theme.colorScheme.outlineVariant.withValues(
                                      alpha: 0.3,
                                    )
                                  : theme.colorScheme.outlineVariant,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            widget.message!,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                      if (widget.loadingStep != null &&
                          widget.loadingStep! >= 1 &&
                          widget.loadingStep! <= 3) ...[
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (i) {
                            final step = widget.loadingStep!;
                            final active = i + 1 <= step;
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: active
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.surfaceContainerHighest,
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${widget.loadingStep}/3',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      Text(
                        'Bu işlem birkaç saniye sürebilir.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant
                              .withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
