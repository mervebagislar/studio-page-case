/// Single source for border radius. No magic numbers.
class AppRadius {
  const AppRadius._();
  static const double small = 8;
  static const double medium = 12;
  static const double statusBox = 14;
  static const double card = 16;
  static const double section = 20;
  static const double large = 24;
}

/// Single source for padding/spacing. No magic numbers.
class AppSpacing {
  const AppSpacing._();
  static const double xs = 4;
  static const double subtextGap = 2;
  static const double sm = 8;
  static const double md = 12;
  static const double iconBox = 10;
  static const double statusIconPadding = 11;
  static const double headerGap = 14;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
}

/// Editor tab. Must align with studio_page and dashboard.
enum EditorTab {
  visual,
  instagram,
  video,
  customPrompt,
  background,
  savedResults,
  generations,
}

/// Tab title for StudioHeader.
String? studioHeaderTitleForTab(EditorTab tab) {
  switch (tab) {
    case EditorTab.visual:
      return 'Görsel Editörü';
    case EditorTab.instagram:
      return 'Instagram Estetik';
    case EditorTab.video:
      return 'Video Editörü';
    case EditorTab.customPrompt:
      return 'Özel Prompt';
    case EditorTab.background:
      return 'Arka Plan Değiştir';
    case EditorTab.savedResults:
      return 'Kaydedilen Görseller';
    case EditorTab.generations:
      return 'Üretimler';
  }
}

/// Loading screen title; gives context by generation type.
String studioLoadingTitleForTab(EditorTab? tab) {
  if (tab == null) return 'İçerik oluşturuluyor';
  switch (tab) {
    case EditorTab.visual:
      return 'Görsel oluşturuluyor';
    case EditorTab.instagram:
      return 'Instagram içeriği oluşturuluyor';
    case EditorTab.video:
      return 'Video oluşturuluyor';
    case EditorTab.customPrompt:
    case EditorTab.background:
      return 'İçerik oluşturuluyor';
    case EditorTab.savedResults:
    case EditorTab.generations:
      return 'İçerik oluşturuluyor';
  }
}

/// Maps loading phase message to step 1..3 for step indicator. Returns null if unknown.
int? loadingStepFromMessage(String? message) {
  if (message == null || message.isEmpty) return null;
  if (message.contains('Üretim başlatılıyor') || message.contains('başlatılıyor')) return 1;
  if (message.contains('Ayarlar işleniyor')) return 2;
  if (message.contains('İçerik oluşturuluyor') || message.contains('oluşturuluyor')) return 3;
  return null;
}
