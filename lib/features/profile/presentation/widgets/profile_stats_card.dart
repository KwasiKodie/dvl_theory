import 'package:flutter/material.dart';

class ProfileStatsCard extends StatelessWidget {
  const ProfileStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: const [
            _StatItem(
              icon: Icons.emoji_events,
              iconColor: Colors.green,
              value: '82%',
              label: 'Overall Progress',
            ),

            _StatItem(
              icon: Icons.assignment,
              iconColor: Colors.blue,
              value: '23',
              label: 'Tests Taken',
            ),

            _StatItem(
              icon: Icons.track_changes,
              iconColor: Colors.pink,
              value: '87%',
              label: 'Best Score',
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
            backgroundColor: iconColor.withOpacity(0.12),

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
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
