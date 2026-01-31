import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_page_case/features/studio/data/generation_service.dart';


final generationServiceProvider = Provider<GenerationService>((ref) {
  return GenerationService();
});
