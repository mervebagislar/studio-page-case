import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/features/studio/data/models/generation_config.dart';
import 'package:studio_page_case/features/studio/state/generation/studio_controller.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/studio_configuration/studio_configuration_animated_section.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/studio_configuration/studio_configuration_section_title.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/studio_configuration/studio_configuration_top_nav.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/studio_configuration/studio_configuration_output_selector.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/studio_configuration/studio_configuration_model_selector.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/studio_configuration/studio_configuration_option_grid.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/studio_configuration/studio_configuration_count_selector.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/studio_configuration/studio_configuration_generate_button.dart';

class StudioConfigurationView extends ConsumerWidget {
  final GenerationConfig config;

  const StudioConfigurationView({super.key, required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 8),
              const StudioConfigurationTopNav(currentTab: 'Görsel'),
              const SizedBox(height: 40),
              StudioConfigurationAnimatedSection(
                delay: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StudioConfigurationSectionTitle(
                      title: '1) İhtiyacın olan çıktıyı seç',
                    ),
                    const SizedBox(height: 16),
                    const StudioConfigurationOutputSelector(
                      selected: 'Website\nKatalog',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              StudioConfigurationAnimatedSection(
                delay: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StudioConfigurationSectionTitle(
                      title: '2) Bir seçim yap',
                    ),
                    const SizedBox(height: 16),
                    const StudioConfigurationModelSelector(
                      selected: 'Mankensiz',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              StudioConfigurationAnimatedSection(
                delay: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StudioConfigurationSectionTitle(title: '3) Style'),
                    const SizedBox(height: 16),
                    StudioConfigurationOptionGrid(
                      options: const [
                        'Realistic',
                        'Artistic',
                        'Abstract',
                        'Minimalist',
                      ],
                      selected: config.style,
                      onSelect: (value) => ref
                          .read(studioControllerProvider.notifier)
                          .updateConfig(config.copyWith(style: value)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              StudioConfigurationAnimatedSection(
                delay: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StudioConfigurationSectionTitle(title: '4) Size'),
                    const SizedBox(height: 16),
                    StudioConfigurationOptionGrid(
                      options: const ['Square', 'Portrait', 'Landscape'],
                      selected: config.size,
                      onSelect: (value) => ref
                          .read(studioControllerProvider.notifier)
                          .updateConfig(config.copyWith(size: value)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              StudioConfigurationAnimatedSection(
                delay: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StudioConfigurationSectionTitle(title: '5) Count'),
                    const SizedBox(height: 16),
                    StudioConfigurationCountSelector(
                      count: config.count,
                      onSelect: (value) => ref
                          .read(studioControllerProvider.notifier)
                          .updateConfig(config.copyWith(count: value)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              StudioConfigurationAnimatedSection(
                delay: 600,
                child: StudioConfigurationGenerateButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    ref.read(studioControllerProvider.notifier).generate();
                  },
                ),
              ),
              const SizedBox(height: 40),
            ]),
          ),
        ),
      ],
    );
  }
}
