import 'package:flutter/material.dart';
import 'package:studio_page_case/features/studio/presentation/widgets/editors/shared/manken_modal_data.dart';

/// Fiziksel Özellikler (Manken Özellikleri) bottom sheet. Visual ve Instagram editörlerinde ortak.
class EditorMankenModal {
  static void show(
    BuildContext context, {
    required MankenModalData initial,
    required LinearGradient gradient,
    required Color accent,
    required ValueChanged<MankenModalData> onSave,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    String? bodyType = initial.bodyType ?? 'Standart';
    String? ethnicity = initial.ethnicity;
    String? skinTone = initial.skinTone;
    String? hairColor = initial.hairColor;
    String? hairLength = initial.hairLength;
    String? ageGroup = initial.ageGroup;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.85,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (_, scrollController) => Container(
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: scheme.onSurfaceVariant.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.manage_accounts_rounded,
                          color: accent,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fiziksel Özellikler (opsiyonel)',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'Manken Özellikleri',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close_rounded,
                            color: scheme.onSurfaceVariant,
                          ),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      children: [
                        _sectionTitle(theme, scheme, 'Beden Seçimi'),
                        Text(
                          'Varsayılan: Standart',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: _chip(
                                theme: theme,
                                scheme: scheme,
                                gradient: gradient,
                                accent: accent,
                                label: 'Standart',
                                isSelected: bodyType == 'Standart',
                                onTap: () =>
                                    setModalState(() => bodyType = 'Standart'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  _chip(
                                    theme: theme,
                                    scheme: scheme,
                                    gradient: gradient,
                                    accent: accent,
                                    label: 'Büyük Beden',
                                    isSelected: bodyType == 'Büyük Beden',
                                    onTap: () => setModalState(
                                        () => bodyType = 'Büyük Beden'),
                                  ),
                                  Positioned(
                                    top: -6,
                                    right: 4,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: gradient,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        'Yeni',
                                        style: theme.textTheme.labelSmall
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 10,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (bodyType == 'Büyük Beden') ...[
                          const SizedBox(height: 8),
                          Text(
                            'Büyük Beden seçeneği, kıvrımlı ve büyük beden modeller için yönlendirme ekler. Standart akış etkilenmez.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        _dropdownSection(
                          theme: theme,
                          scheme: scheme,
                          gradient: gradient,
                          accent: accent,
                          title: 'Etnik Köken',
                          value: ethnicity,
                          options: const [
                            'Beyaz',
                            'Siyahi',
                            'İskandinav',
                            'Avrupalı',
                            'Asyalı',
                            'Hintli',
                            'Afrikalı',
                            'Latin',
                            'Orta Doğulu',
                            'Diğer',
                          ],
                          onClear: () => setModalState(() => ethnicity = null),
                          onSelect: (v) => setModalState(() => ethnicity = v),
                        ),
                        const SizedBox(height: 20),
                        _dropdownSection(
                          theme: theme,
                          scheme: scheme,
                          gradient: gradient,
                          accent: accent,
                          title: 'Ten Tonu',
                          value: skinTone,
                          options: const [
                            'Çok Açık',
                            'Açık',
                            'Orta',
                            'Koyu',
                            'Diğer',
                          ],
                          onClear: () => setModalState(() => skinTone = null),
                          onSelect: (v) => setModalState(() => skinTone = v),
                        ),
                        const SizedBox(height: 20),
                        _dropdownSection(
                          theme: theme,
                          scheme: scheme,
                          gradient: gradient,
                          accent: accent,
                          title: 'Saç Rengi',
                          value: hairColor,
                          options: const [
                            'Siyah',
                            'Kahverengi',
                            'Sarı',
                            'Kızıl',
                            'Gri',
                            'Diğer',
                          ],
                          onClear: () => setModalState(() => hairColor = null),
                          onSelect: (v) => setModalState(() => hairColor = v),
                        ),
                        const SizedBox(height: 20),
                        _dropdownSection(
                          theme: theme,
                          scheme: scheme,
                          gradient: gradient,
                          accent: accent,
                          title: 'Saç Uzunluğu',
                          value: hairLength,
                          options: const ['Short', 'Medium', 'Long'],
                          onClear: () =>
                              setModalState(() => hairLength = null),
                          onSelect: (v) =>
                              setModalState(() => hairLength = v),
                        ),
                        const SizedBox(height: 20),
                        _sectionTitle(
                          theme,
                          scheme,
                          'Yüz Referansı (Karakter Fotoğrafı)',
                        ),
                        Text(
                          'Yüz referansı için model seçin.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.photo_library_rounded,
                            size: 20,
                          ),
                          label: const Text('Kütüphaneyi Aç'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: accent,
                            side: BorderSide(
                              color: accent.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _dropdownSection(
                          theme: theme,
                          scheme: scheme,
                          gradient: gradient,
                          accent: accent,
                          title: 'Yaş Grubu',
                          value: ageGroup,
                          options: const [
                            '0-3',
                            '3-5',
                            '5-10',
                            '10-15',
                            '15-20',
                            '20-25',
                            '25-30',
                            '30-35',
                            '35-40',
                          ],
                          onClear: () => setModalState(() => ageGroup = null),
                          onSelect: (v) => setModalState(() => ageGroup = v),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(ctx),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  side: BorderSide(color: scheme.outline),
                                ),
                                child: const Text('İptal'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Builder(
                                builder: (context) {
                                  final canSave =
                                      bodyType != null &&
                                      ethnicity != null &&
                                      skinTone != null &&
                                      hairColor != null &&
                                      hairLength != null &&
                                      ageGroup != null;
                                  return Opacity(
                                    opacity: canSave ? 1 : 0.6,
                                    child: FilledButton(
                                      onPressed: canSave
                                          ? () {
                                              onSave(MankenModalData(
                                                bodyType: bodyType,
                                                ethnicity: ethnicity,
                                                skinTone: skinTone,
                                                hairColor: hairColor,
                                                hairLength: hairLength,
                                                ageGroup: ageGroup,
                                              ));
                                              Navigator.pop(ctx);
                                            }
                                          : () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Kaydetmek için tüm alanları doldurun: Beden, Etnik Köken, Ten Tonu, Saç Rengi, Saç Uzunluğu, Yaş Grubu.',
                                                  ),
                                                  duration: Duration(
                                                    seconds: 2,
                                                  ),
                                                ),
                                              );
                                            },
                                      style: FilledButton.styleFrom(
                                        backgroundColor: accent,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                      ),
                                      child: const Text('Kaydet'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget _sectionTitle(
    ThemeData theme,
    ColorScheme scheme,
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w800,
          color: scheme.onSurface,
        ),
      ),
    );
  }

  static Widget _chip({
    required ThemeData theme,
    required ColorScheme scheme,
    required LinearGradient gradient,
    required Color accent,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            gradient: isSelected ? gradient : null,
            color: isSelected ? null : scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
            border: isSelected
                ? Border.all(color: Colors.white.withValues(alpha: 0.3))
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: isSelected ? Colors.white : scheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _dropdownSection({
    required ThemeData theme,
    required ColorScheme scheme,
    required LinearGradient gradient,
    required Color accent,
    required String title,
    required String? value,
    required List<String> options,
    required VoidCallback onClear,
    required ValueChanged<String> onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: scheme.onSurface,
              ),
            ),
            if (value != null) ...[
              const SizedBox(width: 8),
              TextButton(
                onPressed: onClear,
                child: Text(
                  'Seçimi temizle',
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((opt) {
            final isSelected = value == opt;
            return GestureDetector(
              onTap: () => onSelect(opt),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected ? gradient : null,
                  color: isSelected ? null : scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(color: Colors.white.withValues(alpha: 0.3))
                      : null,
                ),
                child: Text(
                  opt,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: isSelected ? Colors.white : scheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
