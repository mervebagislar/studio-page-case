import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/visual_editor/visual_editor_helpers.dart';

/// Yeniden kullanılabilir ürün fotoğrafı yükleme modalı.
/// İpuçları, örnek kılavuz ve yükleme butonu içerir.
class ImageUploadModal extends StatelessWidget {
  final String title;
  final String subtitle;
  final LinearGradient gradient;
  final Color shadowColor;
  final VoidCallback onUploadTap;
  final String uploadButtonLabel;
  final String? formatHint;

  const ImageUploadModal({
    super.key,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.shadowColor,
    required this.onUploadTap,
    this.uploadButtonLabel = 'Fotoğraf Yükle',
    this.formatHint = 'JPEG, PNG veya WEBP (maks. 25 MB)',
  });

  /// Modal'ı bottom sheet olarak açar.
  static void show(
    BuildContext context, {
    required String title,
    required String subtitle,
    required LinearGradient gradient,
    required Color shadowColor,
    required VoidCallback onUploadTap,
    String uploadButtonLabel = 'Fotoğraf Yükle',
    String? formatHint,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ImageUploadModal(
        title: title,
        subtitle: subtitle,
        gradient: gradient,
        shadowColor: shadowColor,
        onUploadTap: onUploadTap,
        uploadButtonLabel: uploadButtonLabel,
        formatHint: formatHint,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: scheme.onSurfaceVariant.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 12, 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor.withValues(alpha: 0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.cloud_upload_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Kapat',
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: ClampingScrollPhysics(),
              ),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  VisualEditorHelpers.buildTipCard(
                    context: context,
                    icon: Icons.check_circle_rounded,
                    title: 'Ürün Netliği',
                    description:
                        'Fotoğrafta ürününüz ön planda ve net bir şekilde görünsün. Bulanık veya karmaşık görsellerden kaçının.',
                  ),
                  const SizedBox(height: 12),
                  VisualEditorHelpers.buildTipCard(
                    context: context,
                    icon: Icons.light_mode_rounded,
                    title: 'İyi Işıklandırma',
                    description:
                        'Gölgesiz, dengeli ve iyi bir ışıklandırma kullanın. Gün ışığı veya stüdyo ışığı harika sonuçlar verir.',
                  ),
                  const SizedBox(height: 12),
                  VisualEditorHelpers.buildTipCard(
                    context: context,
                    icon: Icons.image_rounded,
                    title: 'Sade Arka Plan',
                    description:
                        'Sade ve dikkat dağıtmayan bir arka plan tercih edin. Beyaz, gri veya tek renk fonlar idealdir.',
                  ),
                  const SizedBox(height: 12),
                  VisualEditorHelpers.buildTipCard(
                    context: context,
                    icon: Icons.crop_rounded,
                    title: 'Görsel Yönü',
                    description:
                        'Yatay fotoğraf yüklerseniz yatay, dikey fotoğraf yüklerseniz dikey sonuçlar alırsınız.',
                  ),
                  const SizedBox(height: 24),
                  VisualEditorHelpers.buildGuideCard(
                    context: context,
                    icon: Icons.check_circle_rounded,
                    title: 'Uygun (Doğru)',
                    items: const [
                      'Ürün net ve kadrajda merkezde',
                      'Sade/tek renk arka plan',
                      'Dengeli ve gölgesiz ışık',
                      'Yüksek çözünürlük (en az 1024px)',
                      'Tek ürün, dikkat dağıtıcı unsur yok',
                    ],
                    isGood: true,
                  ),
                  const SizedBox(height: 12),
                  VisualEditorHelpers.buildGuideCard(
                    context: context,
                    icon: Icons.cancel_rounded,
                    title: 'Uygun Değil (Yanlış)',
                    items: const [
                      'Bulanık veya düşük çözünürlük',
                      'Kalabalık/karmaşık arka plan',
                      'Aşırı gölge veya sert ışık',
                      'Metin, watermark veya logo içeren görseller',
                      'Birden fazla ürün ya da kolaj',
                    ],
                    isGood: false,
                  ),
                  const SizedBox(height: 24),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onUploadTap,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          gradient: gradient,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: shadowColor.withValues(alpha: 0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_upload_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                            const SizedBox(width: 14),
                            Text(
                              uploadButtonLabel,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (formatHint != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      formatHint!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
