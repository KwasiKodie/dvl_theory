import 'package:flutter/material.dart';

import 'about_tile.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({super.key});

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

        child: Column(
          children: [
            AboutTile(title: 'What’s New', onTap: () {}),

            const _AboutDivider(),

            AboutTile(title: 'Terms of Use', onTap: () {}),

            const _AboutDivider(),

            AboutTile(title: 'Privacy Policy', onTap: () {}),

            const _AboutDivider(),

            AboutTile(
              title: 'Licenses',
              onTap: () {
                showLicensePage(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutDivider extends StatelessWidget {
  const _AboutDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }
}
