import 'package:flutter/material.dart';

class StudyPreferenceTile extends StatelessWidget {
  final String title;
  final String? value;
  final bool valueMuted;
  final Widget? trailing;
  final VoidCallback? onTap;

  const StudyPreferenceTile({
    super.key,
    required this.title,
    this.value,
    this.valueMuted = false,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final valueWidget = value == null
        ? null
        : Text(
            value!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: valueMuted
                  ? theme.colorScheme.onSurfaceVariant
                  : theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),

            ?valueWidget,

            if (trailing case final trailing?) ...[
              const SizedBox(width: 12),
              trailing,
            ] else if (onTap != null) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
