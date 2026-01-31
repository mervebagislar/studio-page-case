import 'package:flutter_riverpod/flutter_riverpod.dart';

/// When true, the bottom "Productions" bar is hidden (user ended production from results).
final productionEndedProvider = StateProvider<bool>((ref) => false);
