import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/core/theme/app_theme.dart';
import 'package:studio_page_case/features/studio/state/selection/selected_images_controller.dart';
import 'package:studio_page_case/features/studio/state/saved/saved_results_controller.dart';
import 'package:studio_page_case/features/studio/state/generation/generation_history_controller.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_constants.dart';
import 'package:studio_page_case/features/studio/state/ui/studio_ui_provider.dart';

class StudioDashboardBody extends ConsumerWidget {
  const StudioDashboardBody({
    super.key,
    required this.onTabSelected,
  });

  final ValueChanged<EditorTab> onTabSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedImages = ref.watch(selectedImagesControllerProvider);
    final savedResults = ref.watch(savedResultsControllerProvider);
    final historyState = ref.watch(generationHistoryControllerProvider);
    final productionEnded = ref.watch(productionEndedProvider);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (!productionEnded && selectedImages.hasImages) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text(
                'Seçtiğin Görseller',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: selectedImages.entries.length,
                itemBuilder: (context, index) {
                  final entry = selectedImages.entries[index];
                  final label = entry.key;
                  final path = entry.value;
                  final file = File(path);
                  if (!file.existsSync()) return const SizedBox.shrink();
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: scheme.outlineVariant.withValues(alpha: 0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.file(
                              file,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 8,
                            ),
                            color: scheme.surfaceContainerHigh,
                            child: Text(
                              label,
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: MediaQuery.of(context).size.width > 600 ? 0.85 : 0.75,
            ),
            delegate: SliverChildListDelegate([
              _DashboardCard(
                title: 'Görsel Editörü',
                icon: Icons.image_outlined,
                tab: EditorTab.visual,
                gradient: AppTheme.accentGradient,
                description: 'Ürün görselleri oluştur',
                onTap: () => onTabSelected(EditorTab.visual),
              ),
              _DashboardCard(
                title: 'Instagram Estetik',
                icon: Icons.auto_awesome_rounded,
                tab: EditorTab.instagram,
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF6366F1),
                    Color(0xFFD946EF),
                    Color(0xFFF97316),
                  ],
                ),
                description: 'Instagram için görseller',
                badge: 'Yeni',
                badgeGradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF818CF8)],
                ),
                onTap: () => onTabSelected(EditorTab.instagram),
              ),
              _DashboardCard(
                title: 'Video Editörü',
                icon: Icons.videocam_outlined,
                tab: EditorTab.video,
                gradient: const LinearGradient(
                  colors: [Color(0xFFB75CFF), Color(0xFFFF5C9D)],
                ),
                description: 'Video içerik oluştur',
                badge: 'Yeni',
                onTap: () => onTabSelected(EditorTab.video),
              ),
              _DashboardCard(
                title: 'Özel Prompt',
                icon: Icons.edit_outlined,
                tab: EditorTab.customPrompt,
                gradient: const LinearGradient(
                  colors: [Color(0xFF9333EA), Color(0xFFB75CFF)],
                ),
                description: 'Kendi prompt\'unu yaz',
                onTap: () => onTabSelected(EditorTab.customPrompt),
              ),
              _DashboardCard(
                title: 'Arka Plan Değiştir',
                icon: Icons.layers_outlined,
                tab: EditorTab.background,
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF5C9D), Color(0xFFFF8A65)],
                ),
                description: 'Arka planı değiştir',
                badge: 'Yeni',
                onTap: () => onTabSelected(EditorTab.background),
              ),
              _DashboardCard(
                title: 'Üretimlerim',
                icon: Icons.history_rounded,
                tab: EditorTab.generations,
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFFC084FC)],
                ),
                description: historyState.hasGenerations
                    ? '${historyState.generations.length} üretim kaydedildi'
                    : 'Geçmiş üretimlerini burada gör',
                badge: historyState.hasGenerations
                    ? '${historyState.generations.length}'
                    : null,
                onTap: () => onTabSelected(EditorTab.generations),
              ),
              _DashboardCard(
                title: 'Kaydedilen Görseller',
                icon: Icons.photo_library_rounded,
                tab: EditorTab.savedResults,
                gradient: const LinearGradient(
                  colors: [Color(0xFF0EA5E9), Color(0xFF06B6D4)],
                ),
                description: savedResults.hasResults
                    ? '${savedResults.results.length} görsel kaydedildi'
                    : 'Seçtiğin sonuçları burada gör',
                badge: savedResults.hasResults ? '${savedResults.results.length}' : null,
                onTap: () => onTabSelected(EditorTab.savedResults),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
    required this.title,
    required this.icon,
    required this.tab,
    required this.gradient,
    required this.description,
    required this.onTap,
    this.badge,
    this.badgeGradient,
  });

  final String title;
  final IconData icon;
  final EditorTab tab;
  final LinearGradient gradient;
  final String description;
  final VoidCallback onTap;
  final String? badge;
  final LinearGradient? badgeGradient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: gradient.colors.first.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (badge != null)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: badgeGradient,
                    color: badgeGradient == null ? Colors.white : null,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    badge!,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: badgeGradient != null ? Colors.white : gradient.colors.first,
                      fontWeight: FontWeight.w800,
                      fontSize: 10,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
