import 'package:studio_page_case/features/studio/data/models/generation_config.dart';
import 'package:studio_page_case/features/studio/data/models/generation_result.dart';

class Generation {
  final String id;
  final String type;
  final GenerationConfig config;
  final List<GenerationResult> results;
  final DateTime createdAt;

  const Generation({
    required this.id,
    required this.type,
    required this.config,
    required this.results,
    required this.createdAt,
  });

  int get imageCount => results.length;
}
