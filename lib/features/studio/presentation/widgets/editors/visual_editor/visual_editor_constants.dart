/// Sabit veri: Visual Editor kategori ve seçenek listeleri.
/// View sadece orchestration yapar; lookup bu dosyadan import edilir.
class VisualEditorConstants {
  VisualEditorConstants._();

  /// Obje seçenekleri (Editorial Stüdyo)
  static const Map<String, List<String>> editorialObjectCategories = {
    'Doğa & Organik': [
      'Taze Çiçekler (Vazoda)',
      'Kuru Bitkiler / Dallar',
      'Tropikal Yapraklar',
      'Meyveler',
      'Doğal Taşlar / Mermer',
      'Deniz Kabukları',
    ],
    'Dekoratif & Sanatsal': [
      'Seramik Vazo / Kase',
      'Cam Şişe / Sürahi',
      'Geometrik Metal Objeler',
      'Minyatür Heykel / Büst',
      'Eski Kitaplar',
      'Mum / Mumluk',
    ],
    'Tekstil & Doku': [
      'İpek / Saten Kumaş',
      'Keten / Pamuk Örtü',
      'Hasır / Rattan Tepsi',
    ],
    'Soyut & Geometrik': [
      'Ahşap Küpler / Bloklar',
      'Alçı Formlar',
      'Renkli Akrilik Levhalar',
    ],
  };

  /// Mekan Seçimi - Kategoriye göre mekanlar. En fazla 1 seçim.
  static const Map<String, List<String>> outdoorLocationCategories = {
    'Kent & Mimari': ['Modern Cadde', 'Tarihi Sokak', 'Minimalist Mimari'],
    'Doğa & Manzara': [
      'Kumsal / Sahil',
      'Park / Botanik Bahçe',
      'Orman Patikası',
      'Kayalık Kıyı',
      'Lavanta Tarlası',
    ],
    'Sosyal & Yaşam Alanları': [
      'Açık Hava Kafe',
      'Pazar Yeri',
      'Tren İstasyonu',
      'Yat Limanı',
      'Sakin Bir Veranda',
      'Ev',
      'Otel Lobisi',
    ],
  };
}
