import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton, CupertinoIcons;

/// Generation hatası sonrası kullanıcıya gösterilen ekran.
/// Açık ve anlaşılır mesaj + Tekrar Dene / Geri aksiyonları. iOS’ta Cupertino stil.
class StudioErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  const StudioErrorView({
    super.key,
    required this.message,
    required this.onRetry,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  theme.scaffoldBackgroundColor,
                  const Color(0xFFF43F5E).withValues(alpha: 0.06),
                  theme.scaffoldBackgroundColor,
                ]
              : [
                  theme.scaffoldBackgroundColor,
                  const Color(0xFFF43F5E).withValues(alpha: 0.04),
                  const Color(0xFFF59E0B).withValues(alpha: 0.04),
                ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: scheme.errorContainer.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.error_outline_rounded,
                          size: 64,
                          color: scheme.error,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Bir hata oluştu',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: scheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHighest
                              .withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: scheme.outlineVariant.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Text(
                          message,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: scheme.onSurfaceVariant,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: isIOS
                            ? CupertinoButton.filled(
                                onPressed: onRetry,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                borderRadius: BorderRadius.circular(12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.refresh,
                                        size: 22, color: scheme.onPrimary),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Tekrar Dene',
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        color: scheme.onPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : FilledButton.icon(
                                onPressed: onRetry,
                                icon:
                                    const Icon(Icons.refresh_rounded, size: 22),
                                label: const Text('Tekrar Dene'),
                                style: FilledButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  backgroundColor: scheme.primary,
                                  foregroundColor: scheme.onPrimary,
                                ),
                              ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: isIOS
                            ? CupertinoButton(
                                onPressed: onBack,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                borderRadius: BorderRadius.circular(12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.back,
                                        size: 20, color: scheme.primary),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Geri',
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        color: scheme.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : OutlinedButton.icon(
                                onPressed: onBack,
                                icon: const Icon(Icons.arrow_back_rounded,
                                    size: 20),
                                label: const Text('Geri'),
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
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
