import 'dart:math';
import 'package:studio_page_case/features/studio/data/models/generation_result.dart';

/// Asset paths under assets/fake/ used as fake result images in mock mode (no backend).
/// Picked randomly per result.
const List<String> kMockResultAssetPaths = [
  'assets/fake/image9.png',
  'assets/fake/image10.png',
  'assets/fake/image11.png',
  'assets/fake/image12.png',
  'assets/fake/image13.png',
  'assets/fake/image14.png',
  'assets/fake/image15.png',
  'assets/fake/image16.png',
];

/// Prefix for imageUrl when value is an asset path (mock). Production uses HTTP URLs.
const String kAssetUrlPrefix = 'asset:';

class GenerationService {
  GenerationService({
    this.enableRandomFailure = true,
    this.fixedDelay,
    this.failureChance = 0.15,
  });

  final bool enableRandomFailure;

  final Duration? fixedDelay;

  final double failureChance;

  Future<List<GenerationResult>> generate(int count) async {
    final random = Random();
    if (enableRandomFailure && random.nextDouble() < failureChance) {
      final failDelay = fixedDelay ?? Duration(seconds: 1 + random.nextInt(2));
      await Future.delayed(failDelay);
      throw Exception('Simulated generation failure for testing error UI');
    }

    final delay = fixedDelay ?? Duration(seconds: 2 + random.nextInt(4));
    await Future.delayed(delay);

    final assets = kMockResultAssetPaths;
    return List.generate(count, (index) {
      final seed = DateTime.now().millisecondsSinceEpoch + index;
      final id = 'img_$seed';
      final colorIndex = index % 6;
      final assetPath = assets[random.nextInt(assets.length)];
      final imageUrl = '$kAssetUrlPrefix$assetPath';

      return GenerationResult(
        id: id,
        imageUrl: imageUrl,
        thumbnailUrl: imageUrl,
        colorIndex: colorIndex,
        createdAt: DateTime.now(),
      );
    });
  }
}
