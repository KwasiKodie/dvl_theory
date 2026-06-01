import 'package:flutter/material.dart';

import 'language_tile.dart';

class LanguageSelectionCard extends StatefulWidget {
  const LanguageSelectionCard({super.key});

  @override
  State<LanguageSelectionCard> createState() => _LanguageSelectionCardState();
}

class _LanguageSelectionCardState extends State<LanguageSelectionCard> {
  String selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),

        child: Column(
          children: [
            LanguageTile(
              code: 'en',
              nativeName: 'English',
              englishName: 'Default',
              selected: selectedLanguage == 'en',
              onTap: () {
                setState(() {
                  selectedLanguage = 'en';
                });
              },
            ),

            const _LanguageDivider(),

            LanguageTile(
              code: 'es',
              nativeName: 'Español',
              englishName: 'Spanish',
              selected: selectedLanguage == 'es',
              onTap: () {
                setState(() {
                  selectedLanguage = 'es';
                });
              },
            ),

            const _LanguageDivider(),

            LanguageTile(
              code: 'fr',
              nativeName: 'Français',
              englishName: 'French',
              selected: selectedLanguage == 'fr',
              onTap: () {
                setState(() {
                  selectedLanguage = 'fr';
                });
              },
            ),

            const _LanguageDivider(),

            LanguageTile(
              code: 'de',
              nativeName: 'Deutsch',
              englishName: 'German',
              selected: selectedLanguage == 'de',
              onTap: () {
                setState(() {
                  selectedLanguage = 'de';
                });
              },
            ),

            const _LanguageDivider(),

            LanguageTile(
              code: 'ar',
              nativeName: 'العربية',
              englishName: 'Arabic',
              selected: selectedLanguage == 'ar',
              onTap: () {
                setState(() {
                  selectedLanguage = 'ar';
                });
              },
            ),
          ],
        ),
      ),
    );
  }
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
