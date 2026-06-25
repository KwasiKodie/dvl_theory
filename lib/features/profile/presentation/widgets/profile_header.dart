import 'package:flutter/material.dart';

import '../../../../core/navigation/route_names.dart';
import '../../domain/services/user_profile_controller.dart';
import 'profile_avatar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = UserProfileController.instance;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Row(
          children: [
            const ProfileAvatar(radius: 36),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.fullName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Keep learning, keep driving\nwith confidence!',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            IconButton.filledTonal(
              tooltip: 'Edit account',
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.account);
              },
              icon: const Icon(Icons.edit, size: 18),
            ),
          ],
        );
      },
    );
  }
}
