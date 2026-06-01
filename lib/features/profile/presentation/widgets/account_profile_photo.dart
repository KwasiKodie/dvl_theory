import 'package:flutter/material.dart';

class AccountProfilePhoto extends StatelessWidget {
  const AccountProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        CircleAvatar(
          radius: 38,

          backgroundColor: theme.colorScheme.surfaceContainerHighest,

          child: Icon(
            Icons.person,
            size: 50,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),

        const SizedBox(height: 12),

        TextButton(onPressed: () {}, child: const Text('Change Photo')),
      ],
    );
  }
}
