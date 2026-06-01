import 'package:flutter/material.dart';

class AboutTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const AboutTile({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22),

        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
