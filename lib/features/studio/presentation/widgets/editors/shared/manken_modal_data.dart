/// Manken modalı "Kaydet" sonrası parent'a iletilen değerler.
/// Visual ve Instagram editörlerinde ortak kullanılır.
class MankenModalData {
  final String? bodyType;
  final String? ethnicity;
  final String? skinTone;
  final String? hairColor;
  final String? hairLength;
  final String? ageGroup;

  const MankenModalData({
    this.bodyType,
    this.ethnicity,
    this.skinTone,
    this.hairColor,
    this.hairLength,
    this.ageGroup,
  });
}
