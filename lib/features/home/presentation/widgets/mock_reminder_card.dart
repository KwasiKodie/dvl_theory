import 'package:flutter/material.dart';

class MockReminderCard extends StatelessWidget {
  final int readinessScore;
  final VoidCallback? onTap;

  const MockReminderCard({super.key, required this.readinessScore, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.green.withValues(alpha: 0.12),
                child: const Icon(
                  Icons.assignment_turned_in,
                  color: Colors.green,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mock Test Recommended',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Your readiness score is $readinessScore%. Take a mock test.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
