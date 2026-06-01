import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: theme.colorScheme.surfaceVariant,

          child: Icon(
            Icons.person,
            size: 42,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                'John Doe',

                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'Keep learning, keep driving\nwith confidence!',

                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),

        CircleAvatar(
          radius: 18,

          backgroundColor: theme.colorScheme.surface,

          child: Icon(Icons.edit, size: 18, color: theme.colorScheme.onSurface),
        ),
      ],
    );
  }
}
