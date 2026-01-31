class GenerationConfig {
  final String style;
  final String size;
  final int count;

  const GenerationConfig({
    this.style = 'Realistic',
    this.size = 'Square',
    this.count = 3,
    this.visualSelections = const {},
  });

  final Map<String, dynamic> visualSelections;

  GenerationConfig copyWith({
    String? style,
    String? size,
    int? count,
    Map<String, dynamic>? visualSelections,
  }) {
    return GenerationConfig(
      style: style ?? this.style,
      size: size ?? this.size,
      count: count ?? this.count,
      visualSelections: visualSelections ?? this.visualSelections,
    );
  }
}
