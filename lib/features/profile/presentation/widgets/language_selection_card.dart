import 'package:flutter/material.dart';

import 'language_tile.dart';

class LanguageSelectionCard extends StatefulWidget {
  const LanguageSelectionCard({super.key});

  @override
  State<LanguageSelectionCard> createState() => _LanguageSelectionCardState();
}

class _LanguageSelectionCardState extends State<LanguageSelectionCard> {
  String selectedLanguage = 'en';

  static const List<_LanguageItem> _languages = [
    _LanguageItem(code: 'en', nativeName: 'English', englishName: 'Default'),
    _LanguageItem(code: 'es', nativeName: 'Español', englishName: 'Spanish'),
    _LanguageItem(code: 'fr', nativeName: 'Français', englishName: 'French'),
    _LanguageItem(code: 'de', nativeName: 'Deutsch', englishName: 'German'),
    _LanguageItem(code: 'ar', nativeName: 'العربية', englishName: 'Arabic'),
  ];

  void _selectLanguage(String code) {
    if (selectedLanguage == code) return;

    setState(() {
      selectedLanguage = code;
    });

    // TODO:
    // Save language preference
    // context.read<LanguageCubit>().changeLanguage(code);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: RadioGroup<String>(
          groupValue: selectedLanguage,
          onChanged: (String? value) {
            if (value == null) return;
            _selectLanguage(value);
          },
          child: Column(
            children: [
              for (int i = 0; i < _languages.length; i++) ...[
                LanguageTile(
                  code: _languages[i].code,
                  nativeName: _languages[i].nativeName,
                  englishName: _languages[i].englishName,
                  selected: selectedLanguage == _languages[i].code,
                  onTap: () => _selectLanguage(_languages[i].code),
                ),
                if (i < _languages.length - 1) const _LanguageDivider(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageItem {
  final String code;
  final String nativeName;
  final String englishName;

  const _LanguageItem({
    required this.code,
    required this.nativeName,
    required this.englishName,
  });
}

class _LanguageDivider extends StatelessWidget {
  const _LanguageDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }
}
