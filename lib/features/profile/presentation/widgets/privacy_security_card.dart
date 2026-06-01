import 'package:flutter/material.dart';

import 'privacy_security_tile.dart';

class PrivacySecurityCard extends StatelessWidget {
  const PrivacySecurityCard({super.key});

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
            PrivacySecurityTile(
              icon: Icons.storage,
              title: 'Data Usage',
              subtitle: 'Control how your data is used',
              onTap: () {},
            ),

            const _PrivacyDivider(),

            PrivacySecurityTile(
              icon: Icons.cleaning_services,
              title: 'Clear Cache',
              subtitle: 'Free up storage space',
              value: '12.4 MB',
              onTap: () {},
            ),

            const _PrivacyDivider(),

            PrivacySecurityTile(
              icon: Icons.file_download_outlined,
              title: 'Export My Data',
              subtitle: 'Download your data',
              onTap: () {},
            ),

            const _PrivacyDivider(),

            PrivacySecurityTile(
              icon: Icons.delete,
              title: 'Delete Account',
              subtitle: 'Permanently delete your account',
              destructive: true,
              onTap: () {
                _showDeleteDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This action cannot be undone. Are you sure you want to permanently delete your account?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _PrivacyDivider extends StatelessWidget {
  const _PrivacyDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }
}
