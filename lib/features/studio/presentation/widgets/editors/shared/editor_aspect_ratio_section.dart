import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_cards.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_utils.dart' show OutputType;

/// Tüm editörlerde ortak en/boy oranı seçimi: 6 oran kartı (Dikey 9:16, 2:3, 4:5, Kare 1:1, Yatay 16:9, 3:2).
/// Görsel editör, Instagram ve Özel Prompt bu widget'ı kullanır.
class EditorAspectRatioSection extends StatelessWidget {
  const EditorAspectRatioSection({
    super.key,
    required this.selectedAspectRatio,
    required this.onAspectRatioSelected,
    required this.outputType,
  });

  final String? selectedAspectRatio;
  final ValueChanged<String?> onAspectRatioSelected;
  final OutputType outputType;

  static const List<({String ratio, String dimensions, IconData icon})> _options = [
    (ratio: 'Dikey (9:16)', dimensions: '576 × 1024', icon: Icons.crop_portrait_rounded),
    (ratio: 'Dikey (2:3)', dimensions: '682 × 1024', icon: Icons.crop_portrait_rounded),
    (ratio: 'Dikey (4:5)', dimensions: '819 × 1024', icon: Icons.crop_portrait_rounded),
    (ratio: 'Kare (1:1)', dimensions: '1024 × 1024', icon: Icons.crop_square_rounded),
    (ratio: 'Yatay (16:9)', dimensions: '1024 × 576', icon: Icons.crop_landscape_rounded),
    (ratio: 'Yatay (3:2)', dimensions: '1536 × 1024', icon: Icons.crop_landscape_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildCard(context, _options[0])),
            const SizedBox(width: 12),
            Expanded(child: _buildCard(context, _options[1])),
            const SizedBox(width: 12),
            Expanded(child: _buildCard(context, _options[2])),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildCard(context, _options[3])),
            const SizedBox(width: 12),
            Expanded(child: _buildCard(context, _options[4])),
            const SizedBox(width: 12),
            Expanded(child: _buildCard(context, _options[5])),
          ],
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, ({String ratio, String dimensions, IconData icon}) option) {
    return VisualEditorCards.buildAspectRatioCard(
      context: context,
      ratio: option.ratio,
      dimensions: option.dimensions,
      icon: option.icon,
      isSelected: selectedAspectRatio == option.ratio,
      onTap: () => onAspectRatioSelected(option.ratio),
      outputType: outputType,
    );
  }
}
