import 'package:flutter/material.dart';

import 'help_support_tile.dart';

class HelpSupportCard extends StatelessWidget {
  const HelpSupportCard({super.key});

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
            HelpSupportTile(
              icon: Icons.help,
              title: 'FAQs',
              subtitle: 'Find answers to common questions',
              onTap: () {},
            ),

            const _HelpDivider(),

            HelpSupportTile(
              icon: Icons.phone,
              title: 'Contact Us',
              subtitle: 'Send us a message',
              onTap: () {},
            ),

            const _HelpDivider(),

            HelpSupportTile(
              icon: Icons.report_problem,
              title: 'Report a Problem',
              subtitle: 'Help us improve the app',
              onTap: () {},
            ),

            const _HelpDivider(),

            HelpSupportTile(
              icon: Icons.star_outline,
              title: 'Rate Our App',
              subtitle: 'Share your feedback',
              onTap: () {},
            ),

            const _HelpDivider(),

            HelpSupportTile(
              icon: Icons.people_alt_outlined,
              title: 'Follow Us',
              subtitle: 'Stay connected on social media',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _HelpDivider extends StatelessWidget {
  const _HelpDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }
}
