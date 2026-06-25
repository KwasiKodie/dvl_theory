import 'package:flutter/material.dart';

import '../../../progress/domain/services/progress_engine.dart';

class ProfileStatsCard extends StatelessWidget {
  const ProfileStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = ProgressEngine();

    final accuracy = progress.overallAccuracy().round();
    final testsTaken = progress.totalAnswered();
    final bestScore = progress.overallAccuracy().round();

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _StatItem(
              icon: Icons.emoji_events,
              iconColor: Colors.green,
              value: '$accuracy%',
              label: 'Overall Progress',
            ),
            _StatItem(
              icon: Icons.assignment,
              iconColor: Colors.blue,
              value: '$testsTaken',
              label: 'Questions Answered',
            ),
            _StatItem(
              icon: Icons.track_changes,
              iconColor: Colors.pink,
              value: '$bestScore%',
              label: 'Accuracy',
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: iconColor.withValues(alpha: 0.12),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
