import 'package:flutter/material.dart';

import 'account_profile_photo.dart';
import 'account_info_tile.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

        child: Column(
          children: [
            const AccountProfilePhoto(),

            const SizedBox(height: 20),

            Divider(color: theme.colorScheme.outlineVariant),

            const AccountInfoTile(title: 'Full Name', value: 'Your Name'),

            const AccountInfoTile(title: 'Email', value: 'your.name@email.com'),

            const AccountInfoTile(title: 'Date of Birth', value: '15 May 1998'),

            const AccountInfoTile(
              title: 'Phone Number',
              value: '+233 (0) XX XXX XXX',
            ),

            Divider(color: theme.colorScheme.outlineVariant),

            ListTile(
              contentPadding: EdgeInsets.zero,

              title: Text(
                'Change Password',

                style: theme.textTheme.titleMedium,
              ),

              trailing: const Icon(Icons.chevron_right),

              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
