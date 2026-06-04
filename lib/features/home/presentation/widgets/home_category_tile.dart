import 'package:flutter/material.dart';

class HomeCategoryTile extends StatelessWidget {
  final String category;
  final double progress;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const HomeCategoryTile({
    super.key,
    required this.category,
    required this.progress,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percent = progress.clamp(0, 100).round();

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 17,
                backgroundColor: color,
                child: Icon(icon, color: Colors.white, size: 19),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: Text(
                  category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: LinearProgressIndicator(
                  value: percent / 100,
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(20),
                  backgroundColor: theme.colorScheme.outlineVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                decoration: BoxDecoration(
                  color: _badgeColor(percent).withOpacity(.18),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '$percent%',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: _badgeColor(percent),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _badgeColor(int value) {
    if (value >= 80) return Colors.green;
    if (value >= 70) return Colors.blue;
    return Colors.orange;
  }
}
