/// Generation type: string values for API/model. Constants instead of magic strings.
enum GenerationType {
  visual('Görsel'),
  video('Video');

  const GenerationType(this.value);
  final String value;
}
