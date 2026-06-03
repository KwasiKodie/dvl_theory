import 'package:flutter/material.dart';

class TopicProgressTile extends StatelessWidget {
  final String category;
  final double progress;

  const TopicProgressTile({
    super.key,
    required this.category,
    required this.progress,
  });

  IconData _iconForCategory() {
    switch (category.toLowerCase()) {
      case 'road signs':
        return Icons.warning_rounded;

      case 'road markings':
        return Icons.add_road;

      case 'traffic rules':
        return Icons.gavel;

      case 'speed limits':
        return Icons.speed;

      case 'hazard awareness':
        return Icons.report_problem;

      case 'safe driving':
        return Icons.directions_car;

      case 'vehicle handling':
        return Icons.directions_car;

      case 'motorway rules':
        return Icons.route;

      case 'pedestrian crossings':
        return Icons.directions_walk;

      case 'emergency procedures':
        return Icons.sos;

      default:
        return Icons.school;
    }
  }

  Color _badgeColor() {
    if (progress >= 80) {
      return Colors.green;
    }

    if (progress >= 70) {
      return Colors.blue;
    }

    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final percent = progress.round();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.dividerColor.withValues(alpha: .15)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: _badgeColor().withValues(alpha: .15),
            child: Icon(_iconForCategory(), color: _badgeColor()),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

                LinearProgressIndicator(
                  value: progress / 100,
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(20),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _badgeColor().withValues(alpha: .15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '$percent%',
              style: TextStyle(
                color: _badgeColor(),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(width: 8),

          Icon(Icons.chevron_right, color: theme.colorScheme.outline),
        ],
      ),
    );
  }
}
