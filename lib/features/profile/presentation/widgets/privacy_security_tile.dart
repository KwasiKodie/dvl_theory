import 'package:flutter/material.dart';

class PrivacySecurityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? value;
  final bool destructive;
  final VoidCallback? onTap;

  const PrivacySecurityTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.value,
    this.destructive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color color = destructive
        ? theme.colorScheme.error
        : theme.colorScheme.onSurface;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),

        child: Row(
          children: [
            Icon(icon, color: color, size: 24),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: destructive
                          ? theme.colorScheme.error.withOpacity(0.8)
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            if (value != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  value!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            Icon(
              Icons.chevron_right,
              color: destructive
                  ? theme.colorScheme.error
                  : theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
